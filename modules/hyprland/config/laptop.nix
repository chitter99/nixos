{ home-manager, username, ... }:
{
  home-manager.users.${username} =  { ... }: {
    home.file = {
      ".config/hypr/hyprpaper.conf".text = ''
preload = ~/.config/backgrounds/232136.png
preload = ~/.config/backgrounds/1A1C23.png
wallpaper = eDP-1, ~/.config/backgrounds/232136.png
      '';  

      ".config/hypr/hyprland.conf".text = ''
#monitor=edp-1,3840 x 2160,auto,auto
monitor=,preferred,auto,auto

exec-once = hyprpaper & waybar & mako & lxqt-policykit-agent & dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# some default env vars.
env=BROWSER, firefox
env=XCURSOR_SIZE,24
env=XDG_CURRENT_DESKTOP,Hyprland
env=XDG_SESSION_DESKTOP,Hyprland
env=XDG_SESSION_TYPE,wayland
env=GDK_BACKEND,wayland,x11
env=QT_QPA_PLATFORM,wayland

$mainMod = SUPER

bind = $mainMod, q, exec, foot 
bind = $mainMod, w, killactive, 
bind = $mainMod, f, fullscreen, 1
bind = $mainMod, d, exec, pavucontrol
bind = $mainMod, m, exit, 
bind = $mainMod, e, exec, kitty -e ranger
bind = $mainMod, b, exec, foot -e btop
bind = $mainMod, v, togglefloating, 
bind = $mainMod, r, exec, wofi --show drun
bind = $mainMod, p, pseudo, # dwindle
bind = $mainMod, j, togglesplit, # dwindle
bind = $mainMod, 0, exec, swaylock
bind = $mainMod, s, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S').png

# Screen backlight
bind = , XF86MonBrightnessUp, exec, brightnessctl set +2%
bind = , XF86MonBrightnessDown, exec, brightnessctl set 2%-

$w1 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/232136.png"
$w2 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/1A1C23.png"
$w3 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/232136.png"
$w4 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/232136.png"
$w5 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/232136.png"
$w6 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/232136.png"
$w7 = hyprctl hyprpaper wallpaper "eDP-1, ~/.config/backgrounds/232136.png"

$wA = 1
$wB = 2
$wC = 3
$wD = 4
$wE = 5
$wF = 6
$wG = 7
$wH = 9
$wI = are ya lost bud

# for all categories, see https://wiki.hyprland.org/configuring/variables/
input {
	kb_layout = ch
	follow_mouse = 1
	touchpad {
		natural_scroll = yes
	}
	sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
	gaps_in = 5
	gaps_out = 10
	border_size = 2

	col.active_border = rgba(0D599Fee) rgba(ffffffee) 45deg
	col.inactive_border = rgba(595959aa)
	
	layout = dwindle
	
	cursor_inactive_timeout = 15
	no_cursor_warps = yes
	resize_on_border = yes
	hover_icon_on_border = yes
}

decoration {
	rounding = 2.5
	
	drop_shadow = yes
	
	shadow_range = 4
	shadow_render_power = 3
	col.shadow = rgba(1a1a1aee)

	active_opacity = 1.0
	inactive_opacity = 1.0
	fullscreen_opacity = 1.0
	
	blur {
		enabled = yes
		size = 8
		passes = 3
		new_optimizations = true
		xray = true
	}
}

animations {
	enabled = yes
	
	bezier = easeOutQuad, 0.5, 1.0, 0.89, 1.0
	
	animation = windows, 1, 7, easeOutQuad
	animation = windowsOut, 1, 7, easeOutQuad, popin 85%
	animation = border, 1, 10, easeOutQuad
	animation = borderangle, 1, 8, easeOutQuad
	animation = fade, 1, 7, easeOutQuad
	animation = workspaces, 1, 6, easeOutQuad
}

dwindle {
	pseudotile = yes # master switch for pseudotiling. enabling is bound to mainmod + p in the keybinds section below
	preserve_split = yes # you probably want this
}

master {
	new_is_master = true
}

gestures {
	workspace_swipe = off
}

device:epic-mouse-v1 {
	sensitivity = -0.5
}

misc {
	disable_hyprland_logo = true
	enable_swallow = true
	swallow_regex = ^(foot)$
	background_color = 0x232136
}

bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

bind = $mainMod shift, left, movewindow, l
bind = $mainMod shift, right, movewindow, r
bind = $mainMod shift, up, movewindow, u
bind = $mainMod shift, down, movewindow, d

bind = $mainMod, 1, workspace, name:$wA
bind = $mainMod, 2, workspace, name:$wB
bind = $mainMod, 3, workspace, name:$wC
bind = $mainMod, 4, workspace, name:$wD
bind = $mainMod, 5, workspace, name:$wE
bind = $mainMod, 6, workspace, name:$wF
bind = $mainMod, 7, workspace, name:$wG
bind = $mainMod, 8, workspace, name:$wH
bind = $mainMod, 9, workspace, name:$wI

bind = $mainMod SHIFT, 1, movetoworkspace,name:$wA
bind = $mainMod SHIFT, 2, movetoworkspace,name:$wB
bind = $mainMod SHIFT, 3, movetoworkspace,name:$wC
bind = $mainMod SHIFT, 4, movetoworkspace,name:$wD
bind = $mainMod SHIFT, 5, movetoworkspace,name:$wE
bind = $mainMod SHIFT, 6, movetoworkspace,name:$wF
bind = $mainMod SHIFT, 7, movetoworkspace,name:$wG
bind = $mainMod SHIFT, 8, movetoworkspace,name:$wH
bind = $mainMod SHIFT, 9, movetoworkspace, name:$wI

bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
      '';

    };
  };
}