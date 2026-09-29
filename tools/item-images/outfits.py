#!/usr/bin/env python3
"""
Gera imagens de outfit a partir dos assets do cliente moderno (15.x).

Por que existe: o servico publico de outfit so conhece ids antigos, e as
outfits de Monk (1824, 1837 e vizinhas) sao posteriores - nao existem nem
nele nem no Tibia.dat de 11.00, que vai ate a 1687. Os assets do proprio
cliente tem todas.

Formato dos assets:
  appearances-*.dat   protobuf, descrito em src/protobuf/appearances.proto
  catalog-content.json  mapeia faixas de sprite id para folhas de sprite
  sprites-*            BMP comprimido em LZMA com cabecalho da CipSoft

Uso:
    python outfits.py --assets <dir> --pb <dir_do_appearances_pb2> \\
                      --out <dir> [--only 1824,1837]
"""

import argparse
import glob
import json
import io
import lzma
import os
import struct
import sys

from PIL import Image

# Marcadores da camada de mascara. Onde o pixel da mascara tem uma dessas
# cores puras, o pixel base e tingido com a cor escolhida pelo jogador.
MASK_HEAD = (255, 255, 0)
MASK_BODY = (255, 0, 0)
MASK_LEGS = (0, 255, 0)
MASK_FEET = (0, 0, 255)

HSI_H_STEPS = 19
HSI_SI_VALUES = 7

DIR_SOUTH = 2  # 0=norte 1=leste 2=sul 3=oeste; o site mostra de frente


def outfit_color(index):
    """Paleta de 133 cores do Tibia, reproduzida do calculo do cliente."""
    if index >= HSI_H_STEPS * HSI_SI_VALUES:
        index = 0

    if index % HSI_H_STEPS != 0:
        loc1 = (index % HSI_H_STEPS) / 18.0
        loc2, loc3 = 1.0, 1.0
        band = index // HSI_H_STEPS
        if band == 0:
            loc2, loc3 = 0.25, 1.00
        elif band == 1:
            loc2, loc3 = 0.25, 0.75
        elif band == 2:
            loc2, loc3 = 0.50, 0.75
        elif band == 3:
            loc2, loc3 = 0.667, 0.75
        elif band == 4:
            loc2, loc3 = 1.00, 1.00
        elif band == 5:
            loc2, loc3 = 1.00, 0.75
        elif band == 6:
            loc2, loc3 = 1.00, 0.50
    else:
        loc1, loc2 = 0.0, 0.0
        loc3 = 1.0 - index / HSI_H_STEPS / HSI_SI_VALUES

    if loc3 == 0:
        return (0, 0, 0)
    if loc2 == 0:
        v = int(loc3 * 255)
        return (v, v, v)

    # HSI -> RGB
    if loc1 < 1.0 / 6.0:
        red, green, blue = loc3, loc3 * (1 - loc2 * (1 - (loc1 * 6))), loc3 * (1 - loc2)
    elif loc1 < 2.0 / 6.0:
        red, green, blue = loc3 * (1 - loc2 * ((loc1 - 1.0 / 6.0) * 6)), loc3, loc3 * (1 - loc2)
    elif loc1 < 3.0 / 6.0:
        red, green, blue = loc3 * (1 - loc2), loc3, loc3 * (1 - loc2 * (1 - ((loc1 - 2.0 / 6.0) * 6)))
    elif loc1 < 4.0 / 6.0:
        red, green, blue = loc3 * (1 - loc2), loc3 * (1 - loc2 * ((loc1 - 3.0 / 6.0) * 6)), loc3
    elif loc1 < 5.0 / 6.0:
        red, green, blue = loc3 * (1 - loc2 * (1 - ((loc1 - 4.0 / 6.0) * 6))), loc3 * (1 - loc2), loc3
    else:
        red, green, blue = loc3, loc3 * (1 - loc2), loc3 * (1 - loc2 * ((loc1 - 5.0 / 6.0) * 6))

    return (int(red * 255), int(green * 255), int(blue * 255))


class SpriteSheets:
    """Resolve sprite id -> imagem, com cache das folhas ja descomprimidas."""

    # spritetype do catalogo -> dimensao do sprite
    SIZES = {0: (32, 32), 1: (32, 64), 2: (64, 32), 3: (64, 64)}

    def __init__(self, assets_dir):
        self.dir = assets_dir
        catalog = json.load(open(os.path.join(assets_dir, "catalog-content.json"),
                                 encoding="utf-8"))
        self.sheets = sorted(
            (e for e in catalog if e.get("type") == "sprite"),
            key=lambda e: e["firstspriteid"],
        )
        self._cache = {}
        self._files = {}

    def _find_sheet(self, sprite_id):
        lo, hi = 0, len(self.sheets) - 1
        while lo <= hi:
            mid = (lo + hi) // 2
            s = self.sheets[mid]
            if sprite_id < s["firstspriteid"]:
                hi = mid - 1
            elif sprite_id > s["lastspriteid"]:
                lo = mid + 1
            else:
                return s
        return None

    def _load(self, sheet):
        key = sheet["file"]
        if key in self._cache:
            return self._cache[key]

        if key not in self._files:
            found = glob.glob(os.path.join(self.dir, key + "*"))
            self._files[key] = found[0] if found else None
        path = self._files[key]
        if not path:
            self._cache[key] = None
            return None

        raw = open(path, "rb").read()

        # Cabecalho da CipSoft, depois LZMA "alone". O campo de tamanho vem
        # incorreto, entao declaramos desconhecido (0xFF*8) e pulamos os 8
        # bytes originais - deixar o valor errado faz o decodificador abortar.
        off = raw.find(b"\x5d\x00\x00")
        if off < 0:
            self._cache[key] = None
            return None
        blob = raw[off:off + 5] + b"\xff" * 8 + raw[off + 13:]
        try:
            data = lzma.LZMADecompressor(format=lzma.FORMAT_ALONE).decompress(blob)
        except lzma.LZMAError:
            self._cache[key] = None
            return None

        img = Image.open(io.BytesIO(data)).convert("RGBA")
        # O BMP vem de cabeca para baixo quando a altura e positiva.
        h = struct.unpack_from("<i", data, 22)[0]
        if h > 0:
            img = img.transpose(Image.FLIP_TOP_BOTTOM)

        # Cache pequeno: um outfit usa poucas folhas, mas cada uma tem 590KB.
        if len(self._cache) > 24:
            self._cache.clear()
        self._cache[key] = img
        return img

    def sprite(self, sprite_id):
        sheet = self._find_sheet(sprite_id)
        if not sheet:
            return None
        img = self._load(sheet)
        if img is None:
            return None

        w, h = self.SIZES.get(sheet["spritetype"], (32, 32))
        per_row = img.width // w
        n = sprite_id - sheet["firstspriteid"]
        x = (n % per_row) * w
        y = (n // per_row) * h
        if y + h > img.height:
            return None
        return img.crop((x, y, x + w, y + h))


def sprite_index(info, layer, pat_x, pat_y, pat_z, frame=0):
    """Ordem do vetor sprite_id, igual a do cliente."""
    layers = info.layers or 1
    pw = info.pattern_width or 1
    ph = info.pattern_height or 1
    pd = info.pattern_depth or 1
    idx = frame
    idx = idx * pd + pat_z
    idx = idx * ph + pat_y
    idx = idx * pw + pat_x
    idx = idx * layers + layer
    return idx


def sprite_at(sheets, info, layer, pat_x, pat_y, pat_z, frame=0):
    """Busca protegida: ha outfits cujo vetor de sprites e menor do que o
    produto dos padroes declarados, e o indice calculado estoura a lista."""
    idx = sprite_index(info, layer, pat_x, pat_y, pat_z, frame)
    if idx < 0 or idx >= len(info.sprite_id):
        return None
    return sheets.sprite(info.sprite_id[idx])


def colorize(base, mask, colors):
    """Tinge o sprite base conforme os marcadores da mascara."""
    out = base.copy()
    bp, mp, op = base.load(), mask.load(), out.load()
    table = {
        MASK_HEAD: colors["head"],
        MASK_BODY: colors["body"],
        MASK_LEGS: colors["legs"],
        MASK_FEET: colors["feet"],
    }
    for y in range(base.height):
        for x in range(base.width):
            br, bg, bb, ba = bp[x, y]
            if ba == 0:
                continue
            mr, mg, mb, ma = mp[x, y]
            if ma == 0:
                continue
            tint = table.get((mr, mg, mb))
            if not tint:
                continue
            op[x, y] = (br * tint[0] // 255, bg * tint[1] // 255, bb * tint[2] // 255, ba)
    return out


def render_outfit(ap, sheets, outfit_id, colors, addons=0):
    entry = ap.get(outfit_id)
    if not entry or not entry.frame_group:
        return None

    # Grupo 0 e a pose parada; o 1, quando existe, e a de caminhada.
    info = entry.frame_group[0].sprite_info
    if not info.sprite_id:
        return None

    layers = info.layers or 1
    pat_y = min(addons, (info.pattern_height or 1) - 1)

    # pattern_depth separa a versao montada da normal, e a ordem nao e a mesma
    # para toda outfit: na 1824 o corpo inteiro esta em z=1, enquanto z=0 traz
    # so o recorte que aparece por cima da montaria. Em vez de fixar um indice,
    # escolhe a profundidade cujo sprite base tem mais pixels visiveis - e
    # sempre o corpo completo.
    best_z, best_px, base = 0, -1, None
    for z in range(info.pattern_depth or 1):
        cand = sprite_at(sheets, info, 0, DIR_SOUTH, pat_y, z)
        if cand is None:
            continue
        visible = sum(1 for a in cand.getchannel("A").getdata() if a > 0)
        if visible > best_px:
            best_z, best_px, base = z, visible, cand

    if base is None:
        return None

    if layers > 1:
        mask = sprite_at(sheets, info, 1, DIR_SOUTH, pat_y, best_z)
        if mask is not None:
            base = colorize(base, mask, colors)

    return base


def save_gif(img, path):
    rgb = Image.new("RGB", img.size, (255, 0, 255))
    rgb.paste(img, mask=img.split()[3])
    pal = rgb.convert("P", palette=Image.ADAPTIVE, colors=255)
    mask = img.split()[3].point(lambda a: 255 if a <= 8 else 0).convert("1")
    pal.paste(255, mask)
    pal.save(path, "GIF", transparency=255)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--assets", required=True)
    p.add_argument("--pb", required=True, help="pasta com appearances_pb2.py")
    p.add_argument("--out", required=True)
    p.add_argument("--only", help="ids separados por virgula")
    p.add_argument("--colors", default="0,0,0,0",
                   help="head,body,legs,feet (indices da paleta)")
    p.add_argument("--export-layers", action="store_true",
                   help="exporta base e mascara em PNG, para o outfit.php "
                        "tingir sob demanda com as cores de cada personagem")
    args = p.parse_args()

    sys.path.insert(0, args.pb)
    import appearances_pb2

    path = glob.glob(os.path.join(args.assets, "appearances-*.dat"))[0]
    proto = appearances_pb2.Appearances()
    proto.ParseFromString(open(path, "rb").read())
    ap = {o.id: o for o in proto.outfit}
    print("  outfits no appearances: %d (ids %d a %d)"
          % (len(ap), min(ap), max(ap)))

    sheets = SpriteSheets(args.assets)
    print("  folhas de sprite: %d" % len(sheets.sheets))

    h, b, l, f = (int(x) for x in args.colors.split(","))
    colors = {
        "head": outfit_color(h), "body": outfit_color(b),
        "legs": outfit_color(l), "feet": outfit_color(f),
    }

    os.makedirs(args.out, exist_ok=True)
    ids = [int(x) for x in args.only.split(",")] if args.only else sorted(ap)

    ok = skipped = 0
    for n, oid in enumerate(ids, 1):
        if args.export_layers:
            ok += export_layers(ap, sheets, oid, args.out)
        else:
            img = render_outfit(ap, sheets, oid, colors)
            if img is None:
                skipped += 1
            else:
                save_gif(img, os.path.join(args.out, "%d.gif" % oid))
                ok += 1
        if n % 200 == 0:
            print("  %d/%d  arquivos=%d vazios=%d" % (n, len(ids), ok, skipped))

    print("\narquivos=%d  vazios=%d" % (ok, skipped))


def export_layers(ap, sheets, outfit_id, out_dir):
    """Grava base e mascara por nivel de addon, sem cor aplicada.

    Quem tinge e o outfit.php, porque a cor depende do personagem que esta
    sendo exibido e nao daria para pre-renderizar todas as combinacoes:
    sao 133 cores em quatro partes do corpo.
    """
    entry = ap.get(outfit_id)
    if not entry or not entry.frame_group:
        return 0

    info = entry.frame_group[0].sprite_info
    if not info.sprite_id:
        return 0

    layers = info.layers or 1
    written = 0

    for pat_y in range(info.pattern_height or 1):
        best_z, best_px, base = 0, -1, None
        for z in range(info.pattern_depth or 1):
            cand = sprite_at(sheets, info, 0, DIR_SOUTH, pat_y, z)
            if cand is None:
                continue
            visible = sum(1 for a in cand.getchannel("A").getdata() if a > 0)
            if visible > best_px:
                best_z, best_px, base = z, visible, cand

        if base is None or best_px <= 0:
            continue

        base.save(os.path.join(out_dir, "%d_%d_base.png" % (outfit_id, pat_y)))
        written += 1

        if layers > 1:
            mask = sprite_at(sheets, info, 1, DIR_SOUTH, pat_y, best_z)
            if mask is not None:
                mask.save(os.path.join(out_dir, "%d_%d_mask.png" % (outfit_id, pat_y)))
                written += 1

    return written


if __name__ == "__main__":
    main()
