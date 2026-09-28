#!/usr/bin/env python3
"""
Gera as imagens de item do MyAAC a partir dos arquivos Tibia.dat / Tibia.spr.

Por que existe: o gerador embutido do MyAAC (system/libs/items_images.php)
exige um items.otb, formato que o crystalserver abandonou - ele usa items.xml
com client ids. Este script le o .dat/.spr direto e escreve os .gif que o
site espera em myacc/images/items/.

Uso:
    python generate.py --dat <Tibia.dat> --spr <Tibia.spr> --out <dir>
    python generate.py ... --only 3354,3355      # so alguns ids, para testar
"""

import argparse
import os
import struct
import sys

from PIL import Image

SPRITE_SIZE = 32

# Atributos do .dat que carregam dados extras; os demais sao marcadores de um
# byte so.
#
# A numeracao vale para clientes 10.10+ (este .dat e 11.00). Em 10.10 a CipSoft
# inseriu NoMoveAnimation no indice 16, empurrando todos os seguintes em um.
# Usar a tabela antiga faz o parser ler o numero errado de bytes e o desvio se
# acumula ate estourar o fim do arquivo.
ATTR_EXTRA = {
    0: "H",    # ground: velocidade
    8: "H",    # writable: tamanho maximo do texto
    9: "H",    # writable once
    22: "HH",  # light: intensidade e cor
    25: "HH",  # displacement: deslocamento x e y
    26: "H",   # elevation
    29: "H",   # cor no minimapa
    30: "H",   # lens help
    33: "H",   # cloth
    35: "H",   # usable
}
ATTR_MARKET = 34
ATTR_END = 255


class Reader:
    """Leitura sequencial com posicao, para relatar onde um parse falhou."""

    def __init__(self, data):
        self.d = data
        self.p = 0

    def u8(self):
        v = self.d[self.p]
        self.p += 1
        return v

    def u16(self):
        v = struct.unpack_from("<H", self.d, self.p)[0]
        self.p += 2
        return v

    def u32(self):
        v = struct.unpack_from("<I", self.d, self.p)[0]
        self.p += 4
        return v

    def i32(self):
        v = struct.unpack_from("<i", self.d, self.p)[0]
        self.p += 4
        return v

    def string(self):
        n = self.u16()
        s = self.d[self.p:self.p + n]
        self.p += n
        return s.decode("latin-1")

    def skip(self, n):
        self.p += n


def parse_dat(path):
    """Devolve {item_id: [sprite_ids]} e os metadados de tamanho do item."""
    raw = open(path, "rb").read()
    r = Reader(raw)

    signature = r.u32()
    item_count = r.u16()
    outfit_count = r.u16()
    effect_count = r.u16()
    missile_count = r.u16()

    items = {}
    for item_id in range(100, item_count + 1):
        # --- atributos ---
        while True:
            attr = r.u8()
            if attr == ATTR_END:
                break
            if attr == ATTR_MARKET:
                r.u16()      # categoria
                r.u16()      # trade as
                r.u16()      # show as
                r.string()   # nome
                r.u16()      # vocacao
                r.u16()      # nivel minimo
            elif attr in ATTR_EXTRA:
                for code in ATTR_EXTRA[attr]:
                    r.u16() if code == "H" else r.u8()
            # os demais nao carregam dado extra

        # --- geometria e sprites ---
        width = r.u8()
        height = r.u8()
        if width > 1 or height > 1:
            r.u8()  # exact size

        layers = r.u8()
        pattern_x = r.u8()
        pattern_y = r.u8()
        pattern_z = r.u8()
        frames = r.u8()

        if frames > 1:
            # Grupo de animacao (clientes 10.50+).
            r.u8()   # async
            r.i32()  # loop count
            r.u8()   # fase inicial
            for _ in range(frames):
                r.u32()  # duracao minima
                r.u32()  # duracao maxima

        total = width * height * layers * pattern_x * pattern_y * pattern_z * frames
        sprite_ids = [r.u32() for _ in range(total)]

        items[item_id] = {
            "w": width,
            "h": height,
            "layers": layers,
            "px": pattern_x,
            "py": pattern_y,
            "pz": pattern_z,
            "frames": frames,
            "sprites": sprite_ids,
        }

    return {
        "signature": signature,
        "items": items,
        "counts": (item_count, outfit_count, effect_count, missile_count),
        "consumed": r.p,
        "total": len(raw),
    }


class SprFile:
    """Acesso sob demanda ao .spr; o arquivo tem centenas de MB."""

    def __init__(self, path):
        self.f = open(path, "rb")
        self.signature, self.count = struct.unpack("<II", self.f.read(8))
        self.offsets = struct.unpack("<%dI" % self.count, self.f.read(4 * self.count))

    def sprite(self, sprite_id):
        """Devolve uma imagem RGBA 32x32, ou None se o sprite for vazio."""
        if sprite_id <= 0 or sprite_id > self.count:
            return None
        offset = self.offsets[sprite_id - 1]
        if offset == 0:
            return None

        self.f.seek(offset)
        self.f.read(3)  # cor-chave de transparencia, nao usada: o formato ja
                        # diz quantos pixels sao transparentes
        size = struct.unpack("<H", self.f.read(2))[0]
        data = self.f.read(size)

        img = Image.new("RGBA", (SPRITE_SIZE, SPRITE_SIZE), (0, 0, 0, 0))
        px = img.load()

        pos = 0
        pixel = 0
        total_px = SPRITE_SIZE * SPRITE_SIZE
        while pos + 4 <= len(data) and pixel < total_px:
            transparent, colored = struct.unpack_from("<HH", data, pos)
            pos += 4
            pixel += transparent
            for _ in range(colored):
                if pos + 3 > len(data) or pixel >= total_px:
                    break
                r, g, b = data[pos], data[pos + 1], data[pos + 2]
                pos += 3
                px[pixel % SPRITE_SIZE, pixel // SPRITE_SIZE] = (r, g, b, 255)
                pixel += 1

        return img


def render_item(meta, spr):
    """Monta o primeiro frame do item, juntando os tiles de 32x32."""
    w, h = meta["w"], meta["h"]
    canvas = Image.new("RGBA", (w * SPRITE_SIZE, h * SPRITE_SIZE), (0, 0, 0, 0))

    # Indice no vetor de sprites: a ordem e
    # frame -> pz -> py -> px -> layer -> h -> w
    # Sempre o frame 0, padrao 0 e camada 0: e a pose parada, que e o que o
    # site mostra.
    drew = False
    for y in range(h):
        for x in range(w):
            idx = (x + y * w)  # layer 0, patterns 0, frame 0
            if idx >= len(meta["sprites"]):
                continue
            sid = meta["sprites"][idx]
            tile = spr.sprite(sid)
            if tile is None:
                continue
            # O tile (0,0) do .dat e o canto inferior direito da imagem.
            canvas.alpha_composite(
                tile,
                ((w - 1 - x) * SPRITE_SIZE, (h - 1 - y) * SPRITE_SIZE),
            )
            drew = True

    if not drew or canvas.getbbox() is None:
        return None

    # Sem recorte: o slot do inventario no site tem tamanho fixo, e imagens
    # cortadas no bounding box ficariam de tamanhos diferentes e desalinhadas.
    return canvas


def save_gif(img, path):
    """GIF com transparencia, que e o formato que o template do MyAAC pede."""
    # Converte para paleta reservando o indice 0 para o transparente.
    rgb = Image.new("RGB", img.size, (255, 0, 255))
    rgb.paste(img, mask=img.split()[3])
    pal = rgb.convert("P", palette=Image.ADAPTIVE, colors=255)

    # Reposiciona a cor-chave no fim da paleta e marca como transparente.
    alpha = img.split()[3]
    mask = alpha.point(lambda a: 255 if a <= 8 else 0).convert("1")
    pal.paste(255, mask)
    pal.save(path, "GIF", transparency=255, optimize=False)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dat", required=True)
    ap.add_argument("--spr", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--only", help="lista de ids separados por virgula")
    ap.add_argument("--limit", type=int, default=0)
    args = ap.parse_args()

    print("lendo o .dat ...")
    dat = parse_dat(args.dat)
    items = dat["items"]
    print("  itens: %d   bytes consumidos: %d de %d"
          % (len(items), dat["consumed"], dat["total"]))

    # Se o parse estiver correto, o que sobra e a secao de outfits/efeitos.
    # Consumir o arquivo inteiro ou parar cedo demais denuncia erro na tabela
    # de atributos.
    if dat["consumed"] >= dat["total"]:
        print("  AVISO: o parse consumiu o arquivo todo; a tabela de atributos"
              " pode estar errada", file=sys.stderr)

    print("abrindo o .spr ...")
    spr = SprFile(args.spr)
    print("  sprites: %d" % spr.count)

    os.makedirs(args.out, exist_ok=True)

    if args.only:
        ids = [int(x) for x in args.only.split(",")]
    else:
        ids = sorted(items.keys())
        if args.limit:
            ids = ids[:args.limit]

    ok = skipped = failed = 0
    for n, item_id in enumerate(ids, 1):
        meta = items.get(item_id)
        if not meta:
            skipped += 1
            continue
        try:
            img = render_item(meta, spr)
            if img is None:
                skipped += 1
                continue
            save_gif(img, os.path.join(args.out, "%d.gif" % item_id))
            ok += 1
        except Exception as exc:
            failed += 1
            if failed <= 5:
                print("  falha no item %d: %s" % (item_id, exc), file=sys.stderr)

        if n % 2000 == 0:
            print("  %d/%d  gerados=%d vazios=%d falhas=%d"
                  % (n, len(ids), ok, skipped, failed))

    print("\ngerados=%d  vazios=%d  falhas=%d" % (ok, skipped, failed))


if __name__ == "__main__":
    main()
