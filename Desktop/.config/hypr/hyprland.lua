local colors = require('themes.macchiato')
require('home')
-- require('laptop')
-- require('office')

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local browser     = "zen-browser"
local work        = "helium-browser"
local code        = "code"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("kbuildsycoca6")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 9'")
    --   hl.exec_cmd("hyprshade on vibrance")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in          = 0,
        gaps_out         = 0,
        border_size      = 2,
        col              = {
            active_border   = colors.mauve,
            inactive_border = colors.surface2,
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },
    decoration = {
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow           = {
            enabled = false,
        },
        blur             = {
            enabled = false,
        },
    },
    animations = {
        enabled = false,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
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
        force_default_wallpaper  = -1,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        middle_click_paste       = false,
    },
    cursor = {
        no_warps = true
    }
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout      = "us",
        kb_variant     = "",
        kb_model       = "",
        kb_options     = "",
        kb_rules       = "",
        follow_mouse   = 2,
        sensitivity    = 0,
        accel_profile  = "flat",
        force_no_accel = true,
        touchpad       = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT"

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(work))

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window with SUPER + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = "previous" }))

hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + EQUAL", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind(mainMod .. " + MINUS", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + EQUAL", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
hl.bind(mainMod .. " + SHIFT + MINUS", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot --freeze -m region -o ~/Pictures/Screenshots"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({ match = { class = "obsidian" }, workspace = "3" })
hl.window_rule({ match = { class = "Spotify" }, workspace = "7" })
hl.window_rule({ match = { class = "Element" }, workspace = "8" })

hl.window_rule({ match = { class = "nm-connection-editor " }, float = true })
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "nordvpn-gui" }, float = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })
hl.window_rule({ match = { class = "qalculate-gtk" }, float = true })
