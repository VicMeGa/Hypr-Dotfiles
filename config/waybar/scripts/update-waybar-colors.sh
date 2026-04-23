#!/bin/bash
# Script simple para generar tema de Waybar con pywal
# Método directo con printf para evitar problemas de expansión

WAYBAR_STYLE="$HOME/.config/waybar/style.css"
WAL_COLORS="$HOME/.cache/wal/colors"

# Función para generar colores si se proporciona imagen
generate_colors() {
    if [ -n "$1" ] && [ -f "$1" ]; then
        echo "🎨 Generando colores para: $(basename "$1")"
        wal -i "$1" -q
        echo "✅ Colores generados"
    elif [ -n "$1" ]; then
        echo "❌ Error: Archivo no encontrado: $1"
        exit 1
    fi
}

# Función principal
main() {
    # Generar colores si se proporciona imagen
    generate_colors "$1"
    
    # Verificar que existen los colores de pywal
    if [ ! -f "$WAL_COLORS" ]; then
        echo "❌ Error: No se encontraron colores de pywal"
        echo "Ejecuta: wal -i /ruta/a/imagen.jpg"
        exit 1
    fi
    
    # Cargar colores
    source "$WAL_COLORS"
    
    echo "🔧 Generando CSS con colores:"
    echo "   Background: $background"
    echo "   Foreground: $foreground"
    echo "   Accent: $color1"
    
    # Convertir background a RGB para transparencia
    bg_hex="${background#\#}"
    bg_r=$((16#${bg_hex:0:2}))
    bg_g=$((16#${bg_hex:2:2}))
    bg_b=$((16#${bg_hex:4:2}))
    
    # Crear el CSS usando printf para control total
    printf '/* Tema generado con pywal - %s */\n' "$(date)" > "$WAYBAR_STYLE"
    
    printf '
* {
    min-height: 0;
    min-width: 0;
    font-family: Lexend, "JetBrainsMono NFP";
    font-size: 13px;
    font-weight: 600;
}

window#waybar {
    transition-property: background-color;
    transition-duration: 0.5s;
    background-color: rgba(%d, %d, %d, 0.6);
    margin-top: 9px;
    margin-left: 6px;
    margin-right: 6px;
    border-radius: 0px;
    border-width: 0px;
}

#workspaces {
    margin-left: 0.8rem;
}

#workspaces button {
    padding: 0.3rem 0.6rem;
    margin: 0.4rem 0.25rem;
    border-radius: 6px;
    background-color: %s;
    color: %s;
}

#workspaces button:hover {
    color: %s;
    background-color: %s;
}

#workspaces button.active {
    background-color: %s;
    color: %s;
}

#workspaces button.urgent {
    background-color: %s;
    color: %s;
}

#clock,
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
#mpris {
    padding: 0.3rem 0.6rem;
    margin: 0.4rem 0.25rem;
    border-radius: 6px;
    background-color: %s;
}

#mpris.playing {
    color: %s;
}

#mpris.paused {
    color: %s;
}

#custom-sep {
    padding: 0px;
    color: %s;
}

window#waybar.empty #window {
    background-color: transparent;
}

#cpu {
    color: %s;
}

#memory {
    color: %s;
}

#clock {
    color: %s;
}

#clock.simpleclock {
    color: %s;
}

#window {
    color: %s;
}

#pulseaudio {
    color: %s;
}

#pulseaudio.muted {
    color: %s;
}

#custom-logo {
    color: %s;
}

#custom-power {
    color: %s;
}

#backlight {
    color: %s;
}

#battery {
    color: %s;
}

#battery.critical {
    color: %s;
}

#battery.warning {
    color: %s;
}

#custom-notification {
    color: %s;
}

tooltip {
    background-color: %s;
    border: 2px solid %s;
}
' \
"$bg_r" "$bg_g" "$bg_b" \
"$color0" "$foreground" \
"$background" "$foreground" \
"$color1" "$background" \
"$color9" "$background" \
"$color0" \
"$color2" \
"$color8" \
"$color8" \
"$color3" \
"$color4" \
"$color5" \
"$color2" \
"$foreground" \
"$color6" \
"$color8" \
"$color2" \
"$color9" \
"$color7" \
"$color10" \
"$color9" \
"$color11" \
"$foreground" \
"$background" "$color2" >> "$WAYBAR_STYLE"
    
    echo "✅ CSS generado en: $WAYBAR_STYLE"
    
    # Reiniciar waybar
    echo "🔄 Reiniciando Waybar..."
    pkill waybar 2>/dev/null
    sleep 1
    waybar & disown
    echo "✅ Waybar reiniciado"
    
    echo ""
    echo "🎉 ¡Tema aplicado correctamente!"
}

# Ejecutar
main "$@"