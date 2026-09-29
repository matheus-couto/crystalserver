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

import os
import subprocess
import sys
import threading
import tkinter as tk
import zipfile
from tkinter import filedialog, messagebox, ttk

APP_NAME = "CrandoriaOT"
EXE_NAME = "bin/client.exe"
SITE = "https://crandoriaot.com.br"

BG = "#141821"
FG = "#e8e6e3"
ACCENT = "#c8a24a"
MUTED = "#8b93a7"


def payload_path():
    """O proprio executavel quando compilado; o zip ao lado em modo script."""
    if getattr(sys, "frozen", False):
        return sys.executable
    here = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(here, "client-payload.zip")


def default_target():
    base = os.environ.get("LOCALAPPDATA") or os.path.expanduser("~")
    return os.path.join(base, "Programs", APP_NAME)


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
        self.resizable(False, False)
        self.geometry("520x300")
        self._center()

        self.target = tk.StringVar(value=default_target())
        self.shortcut_desktop = tk.BooleanVar(value=True)
        self.shortcut_menu = tk.BooleanVar(value=True)
        self.running = False

        self._build()

    def _center(self):
        self.update_idletasks()
        w, h = 520, 300
        x = (self.winfo_screenwidth() - w) // 2
        y = (self.winfo_screenheight() - h) // 2
        self.geometry("%dx%d+%d+%d" % (w, h, x, y))

    def _build(self):
        tk.Label(self, text=APP_NAME, bg=BG, fg=ACCENT,
                 font=("Segoe UI", 20, "bold")).pack(pady=(22, 0))
        tk.Label(self, text="Instalacao do cliente de jogo", bg=BG, fg=MUTED,
                 font=("Segoe UI", 9)).pack(pady=(0, 18))

        row = tk.Frame(self, bg=BG)
        row.pack(fill="x", padx=28)
        tk.Label(row, text="Pasta de instalacao", bg=BG, fg=FG,
                 font=("Segoe UI", 9)).pack(anchor="w")

        pick = tk.Frame(self, bg=BG)
        pick.pack(fill="x", padx=28, pady=(4, 14))
        self.entry = tk.Entry(pick, textvariable=self.target, bg="#1e2430",
                              fg=FG, insertbackground=FG, relief="flat",
                              font=("Segoe UI", 9))
        self.entry.pack(side="left", fill="x", expand=True, ipady=5)
        self.browse = tk.Button(pick, text="Procurar", command=self._browse,
                                bg="#2a3240", fg=FG, relief="flat",
                                font=("Segoe UI", 9), padx=12, cursor="hand2")
        self.browse.pack(side="left", padx=(8, 0))

        opts = tk.Frame(self, bg=BG)
        opts.pack(fill="x", padx=28)
        for var, text in ((self.shortcut_desktop, "Atalho na area de trabalho"),
                          (self.shortcut_menu, "Atalho no menu iniciar")):
            tk.Checkbutton(opts, text=text, variable=var, bg=BG, fg=FG,
                           selectcolor="#1e2430", activebackground=BG,
                           activeforeground=FG, relief="flat",
                           font=("Segoe UI", 9)).pack(anchor="w")

        self.status = tk.Label(self, text="", bg=BG, fg=MUTED,
                               font=("Segoe UI", 8))
        self.status.pack(pady=(14, 2))

        style = ttk.Style(self)
        style.theme_use("default")
        style.configure("bar.Horizontal.TProgressbar", troughcolor="#1e2430",
                        background=ACCENT, borderwidth=0, thickness=6)
        self.bar = ttk.Progressbar(self, style="bar.Horizontal.TProgressbar",
                                   length=464, mode="determinate")
        self.bar.pack(padx=28)

        self.action = tk.Button(self, text="Instalar", command=self._start,
                                bg=ACCENT, fg="#1a1a1a", relief="flat",
                                font=("Segoe UI", 10, "bold"),
                                padx=28, pady=7, cursor="hand2")
        self.action.pack(pady=16)

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
        self.action.config(state="disabled", text="Instalando...")
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
                    z.extract(m, target)
                    done += m.file_size
                    pct = done * 100 / total
                    if int(pct) % 2 == 0:
                        self._set("Instalando   %d%%" % pct, pct)

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
        self.action.config(text="Jogar agora", state="normal",
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
        self.action.config(text="Tentar de novo", state="normal")
        self.browse.config(state="normal")
        self.entry.config(state="normal")
        messagebox.showerror(APP_NAME, "A instalacao falhou.\n\n%s" % msg)


if __name__ == "__main__":
    Installer().mainloop()
