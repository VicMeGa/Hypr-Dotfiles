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
    transition-property: transparency;
    transition-duration: 0.5s;
    background-color: transparent;
    margin-top: 9px;
    margin-left: 6px;
    margin-right: 6px;
    border-radius: 0px;
    border-width: 0px;
}}

#workspaces {{
    margin-left: 0.8rem;
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
}}

#workspaces button:hover {{
    color: {background};
    background-color: {foreground};
}}

#workspaces button.active {{
    background-color: {color1};
    color: {background};
}}

#workspaces button.urgent {{
    background-color: {color9};
    color: {background};
}}


#pulseaudio,
#custom-logo,
#custom-power,
#custom-spotify,
#custom-notification,
#battery,
#cpu,
#backlight,
#tray,
#memory,
#window,
#mpris {{
    padding: 0.2rem 0.6rem;
    margin: 0.4rem 0.25rem;
    border-radius: 6px;
    background-color: {color0};
}}

#clock {{
    padding: 0.2rem 0.3rem;
    margin: 0.1rem 0.1rem;
    border-radius: 6px;
    /*background-color: {color0};*/
}}

#group-1 {{
    background-color: {background};
    margin: 0.4rem 0.25rem;
    /*padding: 0.2rem 0.6rem;*/
    border-radius: 8px;
}}

#mpris.playing {{
    color: {color10};
}}

#mpris.paused {{
    color: {color8};
}}

#custom-sep {{
    padding: 0px;
    color: {color8};
}}

window#waybar.empty #window {{
    background-color: transparent;
}}

#cpu {{
    color: {color3};
}}

#memory {{
    color: {color4};
}}

#clock {{
    color: {color5};
}}

#clock.simpleclock {{
    color: {color2};
}}

#window {{
    color: {foreground};
}}

#pulseaudio {{
    color: {color6};
}}

#pulseaudio.muted {{
    color: {color8};
}}

#custom-logo {{
    color: {color2};
}}

#custom-power {{
    color: {color9};
}}

#backlight {{
    color: {color7};
}}

#battery {{
    color: {color10};
}}

#battery.critical {{
    color: {color9};
}}

#battery.warning {{
    color: {color11};
}}

#custom-notification {{
    color: {foreground};
}}

tooltip {{
    background-color: {background};
    border: 2px solid {color2};
}}

"""



css_final = template.format(**theme)
out_css.write_text(css_final, encoding="utf-8")
# print(css_final)