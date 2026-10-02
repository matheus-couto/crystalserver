#!/usr/bin/env python3
"""
Instalador do cliente CrandoriaOT.

O pacote do cliente fica anexado ao proprio executavel. Nao e um recurso do
PyInstaller: o .zip e concatenado no fim do .exe depois da compilacao, e o
zipfile do Python abre isso normalmente - ele procura o indice a partir do
fim do arquivo e desconta o prefixo, que e como todo SFX funciona.

A alternativa seria embutir por --add-data, mas ai o PyInstaller extrairia os
368 MB para a pasta temporaria a cada execucao, antes mesmo da tela aparecer.
"""

import json
import os
import subprocess
import sys
import threading
import tkinter as tk
import zipfile
from tkinter import filedialog, messagebox, ttk

APP_NAME = "CrandoriaOT"
EXE_NAME = "bin/client.exe"
VARIANT_FILE = "installer.json"  # gravado pelo build.py; nao vai para a pasta instalada
SITE = "https://crandoriaot.com.br"

BG = "#141821"
FG = "#e8e6e3"
ACCENT = "#c8a24a"
ACCENT_HOVER = "#dcb75c"
MUTED = "#8b93a7"
FIELD = "#1e2430"
FIELD_EDGE = "#2a3240"

PAD = 30          # respiro lateral da janela
MIN_WIDTH = 540   # piso, para a janela nao encolher com texto curto


def payload_path():
    """O proprio executavel quando compilado; o zip ao lado em modo script."""
    if getattr(sys, "frozen", False):
        return sys.executable
    here = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(here, "client-payload.zip")


def load_variant():
    """Nome e executavel vindos do installer.json do pacote, se houver.

    O mesmo instalador serve o cliente oficial (bin/client.exe) e o OTClient
    (otclient.exe na raiz). Sem o json, vale o cliente oficial. Nomes
    diferentes importam: com o mesmo APP_NAME, instalar um sobrescreveria a
    chave de desinstalacao e os atalhos do outro.
    """
    global APP_NAME, EXE_NAME
    try:
        with zipfile.ZipFile(payload_path()) as z:
            cfg = json.loads(z.read(VARIANT_FILE).decode("utf-8"))
    except Exception:
        return
    APP_NAME = cfg.get("app_name") or APP_NAME
    EXE_NAME = cfg.get("exe") or EXE_NAME


def default_target():
    base = os.environ.get("LOCALAPPDATA") or os.path.expanduser("~")
    return os.path.join(base, "Programs", APP_NAME)


def enable_dpi_awareness():
    """Sem isso o Windows estica a janela como imagem e tudo sai borrado.

    Precisa vir antes de criar a Tk, senao a janela ja nasce com o tamanho
    errado.
    """
    try:
        from ctypes import windll
    except Exception:
        return
    try:
        windll.shcore.SetProcessDpiAwareness(1)  # por monitor
    except Exception:
        try:
            windll.user32.SetProcessDPIAware()   # Windows 7/8
        except Exception:
            pass


def system_dpi():
    try:
        from ctypes import windll
        return windll.user32.GetDpiForSystem()
    except Exception:
        return 0


def make_shortcut(link_path, target, workdir, description):
    """Cria um .lnk pelo PowerShell, evitando dependencia de pywin32."""
    ps = (
        "$s = (New-Object -ComObject WScript.Shell).CreateShortcut('%s');"
        "$s.TargetPath = '%s';"
        "$s.WorkingDirectory = '%s';"
        "$s.Description = '%s';"
        "$s.Save()"
    ) % (link_path, target, workdir, description)
    try:
        subprocess.run(
            ["powershell", "-NoProfile", "-NonInteractive", "-Command", ps],
            check=True, capture_output=True,
            creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
        )
        return True
    except Exception:
        return False


def write_uninstaller(target):
    """Script simples de remocao, referenciado no Adicionar/Remover."""
    path = os.path.join(target, "desinstalar.bat")
    content = (
        "@echo off\r\n"
        "echo Removendo o " + APP_NAME + "...\r\n"
        "reg delete \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\"
        + APP_NAME + "\" /f >nul 2>&1\r\n"
        "del \"%USERPROFILE%\\Desktop\\" + APP_NAME + ".lnk\" >nul 2>&1\r\n"
        "rmdir /s /q \"%APPDATA%\\Microsoft\\Windows\\Start Menu\\Programs\\"
        + APP_NAME + "\" >nul 2>&1\r\n"
        "cd /d \"%~dp0..\"\r\n"
        "rmdir /s /q \"" + target + "\"\r\n"
    )
    with open(path, "w", encoding="cp1252", errors="replace") as f:
        f.write(content)
    return path


def register_uninstall(target, uninstaller, size_kb):
    """Entrada em Adicionar/Remover Programas, so para o usuario atual."""
    key = r"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\%s" % APP_NAME
    values = [
        ("DisplayName", "REG_SZ", APP_NAME),
        ("DisplayIcon", "REG_SZ", os.path.join(target, EXE_NAME.replace("/", "\\"))),
        ("InstallLocation", "REG_SZ", target),
        ("UninstallString", "REG_SZ", '"%s"' % uninstaller),
        ("URLInfoAbout", "REG_SZ", SITE),
        ("NoModify", "REG_DWORD", "1"),
        ("NoRepair", "REG_DWORD", "1"),
        ("EstimatedSize", "REG_DWORD", str(size_kb)),
    ]
    for name, vtype, data in values:
        try:
            subprocess.run(
                ["reg", "add", key, "/v", name, "/t", vtype, "/d", data, "/f"],
                check=True, capture_output=True,
                creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0),
            )
        except Exception:
            return False
    return True


class Installer(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Instalar " + APP_NAME)
        self.configure(bg=BG)

        dpi = system_dpi()
        if dpi:
            # Tk mede fontes em pontos; sem isso elas ficam miudas num
            # monitor 4K e enormes num 1080p com escala alta.
            self.tk.call("tk", "scaling", dpi / 72.0)

        self.target = tk.StringVar(value=default_target())
        self.shortcut_desktop = tk.BooleanVar(value=True)
        self.shortcut_menu = tk.BooleanVar(value=True)
        self.running = False

        self._build()
        self._fit()

    def _fit(self):
        """Dimensiona a janela pelo que os widgets pediram, e so entao centra.

        A versao anterior fixava 520x300. Numa tela com escala do Windows
        acima de 100% as fontes crescem mas o pixel nao, entao o que estava
        embaixo - justamente o botao - saia cortado. Perguntando o tamanho
        ao proprio Tk isso nao acontece em escala nenhuma.
        """
        self.update_idletasks()
        w = max(self.winfo_reqwidth(), MIN_WIDTH)
        h = self.winfo_reqheight()
        x = (self.winfo_screenwidth() - w) // 2
        y = (self.winfo_screenheight() - h) // 3  # um terco: agrada mais que o meio
        self.geometry("%dx%d+%d+%d" % (w, h, x, max(y, 0)))
        self.minsize(w, h)
        self.resizable(False, False)

    def _build(self):
        head = tk.Frame(self, bg=BG)
        head.pack(fill="x", padx=PAD, pady=(26, 0))
        tk.Label(head, text=APP_NAME, bg=BG, fg=ACCENT,
                 font=("Segoe UI", 22, "bold")).pack(anchor="center")
        tk.Label(head, text="Instalacao do cliente de jogo", bg=BG, fg=MUTED,
                 font=("Segoe UI", 9)).pack(anchor="center", pady=(2, 0))

        body = tk.Frame(self, bg=BG)
        body.pack(fill="x", padx=PAD, pady=(22, 0))

        tk.Label(body, text="Pasta de instalacao", bg=BG, fg=FG,
                 font=("Segoe UI", 9)).pack(anchor="w")

        pick = tk.Frame(body, bg=BG)
        pick.pack(fill="x", pady=(5, 0))
        # A borda e um Frame por tras do Entry: o Tk no Windows nao tem
        # borda colorida de 1px em widget classico.
        edge = tk.Frame(pick, bg=FIELD_EDGE)
        edge.pack(side="left", fill="x", expand=True)
        self.entry = tk.Entry(edge, textvariable=self.target, bg=FIELD,
                              fg=FG, insertbackground=FG, relief="flat",
                              font=("Segoe UI", 9))
        self.entry.pack(fill="x", expand=True, padx=1, pady=1, ipady=6)

        self.browse = tk.Button(pick, text="Procurar", command=self._browse,
                                bg=FIELD_EDGE, fg=FG, relief="flat",
                                activebackground="#333c4d", activeforeground=FG,
                                font=("Segoe UI", 9), width=10, cursor="hand2")
        self.browse.pack(side="left", padx=(10, 0), ipady=5)

        opts = tk.Frame(body, bg=BG)
        opts.pack(fill="x", pady=(16, 0))
        for var, text in ((self.shortcut_desktop, "Criar atalho na area de trabalho"),
                          (self.shortcut_menu, "Criar atalho no menu iniciar")):
            tk.Checkbutton(opts, text=text, variable=var, bg=BG, fg=FG,
                           selectcolor=FIELD, activebackground=BG,
                           activeforeground=FG, relief="flat", bd=0,
                           highlightthickness=0, anchor="w",
                           font=("Segoe UI", 9)).pack(fill="x", pady=1)

        prog = tk.Frame(self, bg=BG)
        prog.pack(fill="x", padx=PAD, pady=(20, 0))
        # Altura reservada desde o inicio: sem isso a janela pularia de
        # tamanho no primeiro texto de status.
        self.status = tk.Label(prog, text="Pronto para instalar", bg=BG,
                               fg=MUTED, font=("Segoe UI", 8), anchor="w")
        self.status.pack(fill="x", pady=(0, 6))

        style = ttk.Style(self)
        style.theme_use("default")
        style.configure("bar.Horizontal.TProgressbar", troughcolor=FIELD,
                        background=ACCENT, borderwidth=0, thickness=6)
        self.bar = ttk.Progressbar(prog, style="bar.Horizontal.TProgressbar",
                                   mode="determinate")
        self.bar.pack(fill="x")

        foot = tk.Frame(self, bg=BG)
        foot.pack(fill="x", padx=PAD, pady=(24, 26))
        # width em caracteres, nao em pixels: o botao nao muda de tamanho
        # quando o rotulo vira "Instalando..." ou "Jogar agora".
        self.action = tk.Button(foot, text="Instalar", command=self._start,
                                bg=ACCENT, fg="#16181d", relief="flat",
                                activebackground=ACCENT_HOVER,
                                activeforeground="#16181d",
                                disabledforeground="#6d6552",
                                font=("Segoe UI", 11, "bold"),
                                width=18, cursor="hand2")
        self.action.pack(ipady=9)
        self.action.bind("<Enter>", lambda e: self._hover(True))
        self.action.bind("<Leave>", lambda e: self._hover(False))

        tk.Label(foot, text=SITE, bg=BG, fg=MUTED,
                 font=("Segoe UI", 8)).pack(pady=(14, 0))

    def _hover(self, on):
        if str(self.action["state"]) != "disabled":
            self.action.config(bg=ACCENT_HOVER if on else ACCENT)

    def _browse(self):
        d = filedialog.askdirectory(title="Escolha onde instalar")
        if d:
            self.target.set(os.path.join(d, APP_NAME))

    def _set(self, text, pct=None):
        self.status.config(text=text)
        if pct is not None:
            self.bar["value"] = pct
        self.update_idletasks()

    def _start(self):
        if self.running:
            return
        target = self.target.get().strip()
        if not target:
            messagebox.showwarning(APP_NAME, "Escolha uma pasta de instalacao.")
            return

        self.running = True
        self.action.config(state="disabled", text="Instalando...", bg=FIELD_EDGE)
        self.browse.config(state="disabled")
        self.entry.config(state="disabled")
        threading.Thread(target=self._install, args=(target,), daemon=True).start()

    def _install(self, target):
        try:
            src = payload_path()
            if not os.path.exists(src):
                raise RuntimeError("pacote do cliente nao encontrado")

            os.makedirs(target, exist_ok=True)

            self._set("Lendo o pacote...", 0)
            with zipfile.ZipFile(src) as z:
                members = z.infolist()
                total = sum(m.file_size for m in members) or 1
                done = 0
                for m in members:
                    if m.filename == VARIANT_FILE:
                        continue
                    z.extract(m, target)
                    done += m.file_size
                    pct = done * 100 / total
                    if int(pct) % 2 == 0:
                        self._set("Copiando arquivos   %d%%" % pct, pct)

            self._set("Criando atalhos...", 100)
            exe = os.path.join(target, EXE_NAME.replace("/", "\\"))
            workdir = os.path.dirname(exe)

            if self.shortcut_desktop.get():
                desktop = os.path.join(os.path.expanduser("~"), "Desktop")
                make_shortcut(os.path.join(desktop, APP_NAME + ".lnk"),
                              exe, workdir, APP_NAME)

            if self.shortcut_menu.get():
                menu = os.path.join(os.environ.get("APPDATA", ""),
                                    "Microsoft", "Windows", "Start Menu",
                                    "Programs", APP_NAME)
                os.makedirs(menu, exist_ok=True)
                make_shortcut(os.path.join(menu, APP_NAME + ".lnk"),
                              exe, workdir, APP_NAME)

            uninst = write_uninstaller(target)
            size_kb = sum(
                os.path.getsize(os.path.join(r, f))
                for r, _, fs in os.walk(target) for f in fs
            ) // 1024
            register_uninstall(target, uninst, size_kb)

            self.after(0, self._done, target, exe)

        except Exception as exc:
            self.after(0, self._failed, str(exc))

    def _done(self, target, exe):
        self.running = False
        self._set("Instalado em %s" % target, 100)
        self.action.config(text="Jogar agora", state="normal", bg=ACCENT,
                           command=lambda: self._launch(exe))

    def _launch(self, exe):
        try:
            subprocess.Popen([exe], cwd=os.path.dirname(exe))
        except Exception as exc:
            messagebox.showerror(APP_NAME, "Nao foi possivel abrir o cliente:\n%s" % exc)
        self.destroy()

    def _failed(self, msg):
        self.running = False
        self._set("Falhou: %s" % msg)
        self.action.config(text="Tentar de novo", state="normal", bg=ACCENT)
        self.browse.config(state="normal")
        self.entry.config(state="normal")
        messagebox.showerror(APP_NAME, "A instalacao falhou.\n\n%s" % msg)


if __name__ == "__main__":
    load_variant()
    enable_dpi_awareness()
    Installer().mainloop()
