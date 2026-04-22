import json
from pathlib import Path

WAYBAR_STYLE="$HOME/.config/waybar/style.css"
WAL_COLORS="$HOME/.cache/wal/colors"
IMAGE = ""
ruta_json = Path.home() / ".cache" / "wal" / "colors.json"
out_css = Path.home() / ".config" / "waybar" / "style.css"

def generate_colors():
    subprocess.run(["wal", "-i", IMAGE])

with open(ruta_json) as f:

    colores = json.load(f)

# Acceder a 'special' y 'colors'
special = colores.get("special", {})
colors = colores.get("colors", {})

theme = {**special, **colors}

template = """* {{
    min-height: 0;
    min-width: 0;
    font-family: Lexend, "JetBrainsMono NFP";
    font-size: 13px;
    font-weight: 700;
}}

window#waybar {{
    background-color: transparent;
    margin: 9px 6px 0;
    border-radius: 0;
    transition-property: background-color;
    transition-duration: 0.5s;
}}

/* ── WORKSPACES ─────────────────────────────────── */
#workspaces {{
    background-color: {background};
    margin: 0.4rem 0.25rem;
    border-radius: 8px;
}}

#workspaces button {{
    padding: 0.2rem 0.6rem;
    margin: 0.4rem 0.25rem;
    border-radius: 6px;
    background-color: {color0};
    color: {foreground};
    transition: background-color 0.2s, color 0.2s;
}}

#workspaces button:hover {{
    background-color: {foreground};
    color: {background};
}}

#workspaces button.active {{
    background-color: {color1};
    color: {background};
}}

#workspaces button.urgent {{
    background-color: {color9};
    color: {background};
}}

/* ── MÓDULOS COMUNES ────────────────────────────── */
#pulseaudio,
#custom-logo,
#custom-power,
#custom-spotify,
#custom-notification,
#battery,
#cpu,
#backlight,
#tray,
#custom-network,
#memory,
#window,
#mpris {{
    padding: 0.2rem 0.6rem;
    margin: 0.4rem 0.25rem;
    border-radius: 6px;
    background-color: {color0};
}}

/* ── CLOCK ──────────────────────────────────────── */
#clock {{
    padding: 0.2rem 0.3rem;
    margin: 0.1rem 0.1rem;
    border-radius: 6px;
    color: {color5};
}}

#clock.simpleclock {{
    color: {color2};
}}

/* ── GROUP ──────────────────────────────────────── */
#group-1 {{
    background-color: {background};
    margin: 0.4rem 0.25rem;
    border-radius: 8px;
}}

/* ── MPRIS ──────────────────────────────────────── */
#mpris.playing {{
    color: {color10};
}}

#mpris.paused {{
    color: {color8};
}}

/* ── SEPARADOR ──────────────────────────────────── */
#custom-sep {{
    padding: 0;
    color: {color8};
}}

/* ── WINDOW VACÍO ───────────────────────────────── */
window#waybar.empty #window {{
    background-color: transparent;
}}

/* ── COLORES POR MÓDULO ─────────────────────────── */
#cpu          {{ color: {color3};     }}
#memory       {{ color: {color4};     }}
#pulseaudio   {{ color: {color6};     }}
#backlight    {{ color: {color7};     }}
#battery      {{ color: {color10};    }}
#window       {{ color: {foreground}; }}
#custom-logo  {{ color: {color2};     }}
#custom-power {{ color: {color9};     }}

#custom-notification {{ color: {foreground}; }}
#custom-network  {{ color: {color8}; }}

#pulseaudio.muted  {{ color: {color8}; }}
#battery.critical  {{ color: {color9}; }}
#battery.warning   {{ color: {color11}; }}

/* ── TOOLTIP ────────────────────────────────────── */
tooltip {{
    background-color: {background};
    border: 2px solid {color2};
}}

"""



css_final = template.format(**theme)
out_css.write_text(css_final, encoding="utf-8")
# print(css_final)
