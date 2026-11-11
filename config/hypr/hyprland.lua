-- ##########################################################################
-- hyprland.lua  (migrado desde hyprland.conf, Hyprland 0.55+)
-- Wiki: https://wiki.hypr.land/Configuring/Start/
-- ##########################################################################


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = 1.25,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@240",
    position = "1920x0",
    scale    = 1,
})

-- hl.monitor({ output = "DP-1", mode = "1920x1080@120", position = "1920x0", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nemo"
local menu        = "rofi -show run"
local mainMod     = "SUPER" -- Tecla "Windows" como modificador principal


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar")
    -- hl.exec_cmd("swww-daemon") -- descomenta si waypaper no levanta el daemon solo
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("swaync")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_THEME", "Furina-v2")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")

hl.env("GDK_SCALE", "1.25")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.5")
hl.env("QT_SCALE_FACTOR", "1.10")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("ELECTRON_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_FORCE_DEVICE_SCALE_FACTOR", "1.5") -- Esta es la clave para el escalado

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,

        border_size = 2,

        col = {
            active_border   = "rgba(33ccffee)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee89b4fa, -- equivale a rgba(89b4faee)
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout  = "latam",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        numlock_by_default = true,

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 = sin modificar
        force_no_accel = true,

        touchpad = {
            natural_scroll = true,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})


--------------------
---- ANIMACIONES ---
--------------------

hl.curve("easeStandard", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("easeIn",       { type = "bezier", points = { {0.42, 0.0}, {1.0, 1.0} } })
hl.curve("easeOut",      { type = "bezier", points = { {0.0, 0.0},  {0.58, 1.0} } })
hl.curve("easeInOut",    { type = "bezier", points = { {0.42, 0.0}, {0.58, 1.0} } })
hl.curve("spring",       { type = "bezier", points = { {0.175, 0.885}, {0.32, 1.275} } })
hl.curve("gentle",       { type = "bezier", points = { {0.4, 0.0},  {0.2, 1.0} } })

-- Ventanas
hl.animation({ leaf = "windows",     enabled = true, speed = 1, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 1, bezier = "easeOut",   style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1, bezier = "easeIn",    style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "easeInOut", style = "slide" })

-- Bordes
hl.animation({ leaf = "border",      enabled = true, speed = 1, bezier = "gentle" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 1, bezier = "easeStandard", style = "loop" })

-- Fade
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 3, bezier = "easeIn" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "easeInOut" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "easeOut" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 3, bezier = "easeInOut" })

-- Workspaces
hl.animation({ leaf = "workspaces",       enabled = true, speed = 2, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "easeInOut", style = "slidevert" })

-- Layers (overlays y popups)
hl.animation({ leaf = "layers",    enabled = true, speed = 3, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "layersIn",  enabled = true, speed = 3, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "easeIn",  style = "slide" })


--------------------------------
---- GESTOS Y DISPOSITIVOS  ----
--------------------------------

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


-----------------------
---- WINDOW RULES  ----
-----------------------

-- Scratchpad de kitty (mainMod + F1 lo abre, mainMod + F2 lo muestra/oculta)
hl.window_rule({
    name  = "kitty-drop",
    match = { class = "^(kitty-drop)$" },
    float = true,
    size  = { "(monitor_w*0.9)", "(monitor_h*0.5)" }, -- equivale a 90% x 50%
    center = true,
    workspace = "special:kitty-scratch",
})


---------------------
---- KEYBINDINGS ----
---------------------

-- Scratchpad de kitty
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("kitty --class kitty-drop"))
hl.bind(mainMod .. " + F2", hl.dsp.workspace.toggle_special("kitty-scratch"))

-- Programas y ventanas
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("konsole"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())       -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("/home/victor/.config/SelectWallpaper/wallpaper-selector.sh"))

-- Mover el foco con mainMod + flechas
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Cambiar de workspace con mainMod + [0-9]
-- Mover la ventana activa a un workspace con mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- el workspace 10 usa la tecla 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspace especial (scratchpad "magic")
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Recorrer workspaces con la rueda del mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Cambiar foco entre monitores
hl.bind(mainMod .. " + space", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ monitor = "-1" }))

-- Mover ventana al siguiente/anterior monitor
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.window.move({ monitor = "-1" }))

-- Mover/redimensionar ventanas con mainMod + clic izq/der y arrastrar
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Teclas multimedia: volumen y brillo
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Control de reproductor (requiere playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- hl.bind("XF86PowerOff", hl.dsp.exec_cmd("wlogout"), { locked = true })


---------------------------
---- CAPTURAS DE PANTALLA --
---------------------------

-- Ventana
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o /home/victor/Image/Hyprshot/"))
-- Monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -o /home/victor/Image/Hyprshot/"))
-- Región (en tu .conf usabas $shiftMod, que nunca estuvo definida; lo pasé a SHIFT)
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region -o /home/victor/Image/Hyprshot/"))
-- ##########################################################################
-- hyprland.lua  (migrado desde hyprland.conf, Hyprland 0.55+)
-- Wiki: https://wiki.hypr.land/Configuring/Start/
-- ##########################################################################


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = 1.25,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@240",
    position = "1920x0",
    scale    = 1,
})

-- hl.monitor({ output = "DP-1", mode = "1920x1080@120", position = "1920x0", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nemo"
local menu        = "rofi -show run"
local mainMod     = "SUPER" -- Tecla "Windows" como modificador principal


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar")
    -- hl.exec_cmd("swww-daemon") -- descomenta si waypaper no levanta el daemon solo
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("swaync")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_THEME", "Furina-v2")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")

hl.env("GDK_SCALE", "1.25")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.5")
hl.env("QT_SCALE_FACTOR", "1.10")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("ELECTRON_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_FORCE_DEVICE_SCALE_FACTOR", "1.5") -- Esta es la clave para el escalado

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,

        border_size = 2,

        col = {
            active_border   = "rgba(33ccffee)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee89b4fa, -- equivale a rgba(89b4faee)
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout  = "latam",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        numlock_by_default = true,

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 = sin modificar
        force_no_accel = true,

        touchpad = {
            natural_scroll = true,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})


--------------------
---- ANIMACIONES ---
--------------------

hl.curve("easeStandard", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("easeIn",       { type = "bezier", points = { {0.42, 0.0}, {1.0, 1.0} } })
hl.curve("easeOut",      { type = "bezier", points = { {0.0, 0.0},  {0.58, 1.0} } })
hl.curve("easeInOut",    { type = "bezier", points = { {0.42, 0.0}, {0.58, 1.0} } })
hl.curve("spring",       { type = "bezier", points = { {0.175, 0.885}, {0.32, 1.275} } })
hl.curve("gentle",       { type = "bezier", points = { {0.4, 0.0},  {0.2, 1.0} } })

-- Ventanas
hl.animation({ leaf = "windows",     enabled = true, speed = 1, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 1, bezier = "easeOut",   style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1, bezier = "easeIn",    style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "easeInOut", style = "slide" })

-- Bordes
hl.animation({ leaf = "border",      enabled = true, speed = 1, bezier = "gentle" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 1, bezier = "easeStandard", style = "loop" })

-- Fade
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 3, bezier = "easeIn" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "easeInOut" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "easeOut" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 3, bezier = "easeInOut" })

-- Workspaces
hl.animation({ leaf = "workspaces",       enabled = true, speed = 2, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "easeInOut", style = "slidevert" })

-- Layers (overlays y popups)
hl.animation({ leaf = "layers",    enabled = true, speed = 3, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "layersIn",  enabled = true, speed = 3, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "easeIn",  style = "slide" })


--------------------------------
---- GESTOS Y DISPOSITIVOS  ----
--------------------------------

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


-----------------------
---- WINDOW RULES  ----
-----------------------

-- Scratchpad de kitty (mainMod + F1 lo abre, mainMod + F2 lo muestra/oculta)
hl.window_rule({
    name  = "kitty-drop",
    match = { class = "^(kitty-drop)$" },
    float = true,
    size  = { "(monitor_w*0.9)", "(monitor_h*0.5)" }, -- equivale a 90% x 50%
    center = true,
    workspace = "special:kitty-scratch",
})


---------------------
---- KEYBINDINGS ----
---------------------

-- Scratchpad de kitty
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("kitty --class kitty-drop"))
hl.bind(mainMod .. " + F2", hl.dsp.workspace.toggle_special("kitty-scratch"))

-- Programas y ventanas
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("konsole"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())       -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("/home/victor/.config/SelectWallpaper/wallpaper-selector.sh"))

-- Mover el foco con mainMod + flechas
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Cambiar de workspace con mainMod + [0-9]
-- Mover la ventana activa a un workspace con mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- el workspace 10 usa la tecla 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspace especial (scratchpad "magic")
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Recorrer workspaces con la rueda del mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Cambiar foco entre monitores
hl.bind(mainMod .. " + space", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ monitor = "-1" }))

-- Mover ventana al siguiente/anterior monitor
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.window.move({ monitor = "-1" }))

-- Mover/redimensionar ventanas con mainMod + clic izq/der y arrastrar
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Teclas multimedia: volumen y brillo
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Control de reproductor (requiere playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- hl.bind("XF86PowerOff", hl.dsp.exec_cmd("wlogout"), { locked = true })


---------------------------
---- CAPTURAS DE PANTALLA --
---------------------------

-- Ventana
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o /home/victor/Image/Hyprshot/"))
-- Monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -o /home/victor/Image/Hyprshot/"))
-- Región (en tu .conf usabas $shiftMod, que nunca estuvo definida; lo pasé a SHIFT)
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region -o /home/victor/Image/Hyprshot/"))
