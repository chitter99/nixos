{ home-manager, username, ... }:
{
    home-manager.users.${username} =  { ... }: {
    home.file = {
      ".config/waybar/config.jsonc".text = ''
{
	"layer": "top",
	"height": 36,
	"modules-left": [ "custom/nix", "hyprland/workspaces" ],
	"modules-center": [ ],
	"modules-right": [ "pulseaudio", "backlight", "network", "cpu", "memory", "disk", "bluetooth", "battery", "clock"],
	"custom/nix": {
		"format": " ",
		"tooltip": false,
		"on-click": "/run/current-system/sw/bin/wofi --show drun"
	},
	"hyprland/workspaces": {
		"format": "{name}",
		"tooltip": false,
		"all-outputs": true,
		"format-icons": {
			"active": "",
			"default": ""
		},
		"on-scroll-up": "hyprctl dispatch workspace e+1",
		"on-scroll-down": "hyprctl dispatch workspace e-1",
		"on-click": "activate"
	},
	"cpu": {
		"format": "󰻠  {usage}%",
		"tooltip": true,
		"on-click": "foot sh -c 'btop'",
		"interval": 2
	},
	"memory": {
		"format": "  {}%",
		"tooltip": true,
		"on-click": "foot sh -c 'btop'",
		"interval": 2
	},
	"temperature": {
		// "thermal-zone": 2,
		// "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
		"critical-threshold": 40,
		"format-critical": "{icon} {temperatureC}°C",
		"format": "{icon} {temperatureC}°C",
		"format-icons": [
			"",
			"",
			""
		],
		"interval": 60
	},
	"disk": {
		"format": "  {percentage_used}%",
		"tooltip": true,
		"interval": 60,
		"on-click":"kitty sh -c 'ranger'"
	},
	"clock": {
		"format": "{:%H:%M}",
		//"format": " {:%a %b %d %Y | %H:%M}",
		"format-alt": "{:%a %b %d %Y | %H:%M}",
		"tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
		"calendar-weeks-pos": "right",
		"today-format": "<span color='#f38ba8'><b><u>{}</u></b></span>",
		"format-calendar": "<span color='#f2cdcd'><b>{}</b></span>",
		"format-calendar-weeks": "<span color='#94e2d5'><b>W{:%U}</b></span>",
		"format-calendar-weekdays": "<span color='#f9e2af'><b>{}</b></span>",
		"interval": 60
	},    
	"backlight": {
		"device": "intel_backlight",
		"format": "{icon} {percent}%",
		"format-icons": ["", "", "", "", "", "", "", "", ""],
		"on-scroll-up": "brightnessctl set +2%",
		"on-scroll-down": "brightnessctl set 2%-",
		"interval": 2
	},
	"pulseaudio": {
		// "scroll-step": 1, // %, can be a float
		"format": "{icon} {volume}%", // {format_source}
		"format-bluetooth": "{icon} {volume}%", // {format_source}
		"format-bluetooth-muted": "󰗿", // {format_source}
		"format-muted": "", // {format_source}
		"format-source": "{volume}% ",
		"format-source-muted": "",
		"format-icons": {
			"headphone": "󰋋",
			"headset": "󰋎",
			"phone": "",
			"portable": "",
			"car": " ",
			"default": [
				"",
				"",
				" "
			]
		},
		"on-click": "pavucontrol"
	}, 
	"bluetooth": {
		"format": " {status}",
		"format-disabled": "", // an empty format will hide the module
		"format-connected": " {num_connections}",
		"tooltip-format": "{device_enumerate}",
		"tooltip-format-enumerate-connected": "{device_alias}   {device_address}"      
	},
	"network": {
		"interface": "wlp*",
		"format": "󰱓 ",
		"format-disconnected": "{icon} No Internet",
		"format-linked": "󰅛 {ifname} (No IP)",
		"format-alt": "󰛶 {bandwidthUpBytes} | 󰛴 {bandwidthDownBytes}",
		"tooltip-format": "{ifname}: {ipaddr}/{cidr} Gateway: {gwaddr}",
		"tooltip-format-wifi": "{icon} {essid} ({signalStrength}%)",
		"tooltip-format-ethernet": "{icon} {ipaddr}/{cidr}",
		"tooltip-format-disconnected": "{icon} Disconnected",
		"format-icons": {
			"ethernet": "󰈀",
			"disconnected": "⚠",
			"wifi": [
				"󰖪",
				""
			]
		},
		"interval": 2
	},
	"battery": {
		"states": {
				"good": 100,
				"warning": 30,
				"critical": 10
			},
		"format": "{icon} {capacity}%",
		"format-plugged": "  {capacity}%",
		"format-alt": "{icon} {time}",
			// "format-good": "", // An empty format will hide the module
		"format-full": "  {capacity}%",
		"format-icons": [" ", " ", " ", " ", " ", " "],
		"format-charging": "  {capacity}%",
		"interval": 2
	},
	"custom/power": {
		"format": "{}",
		// "exec": "~/.scripts/tools/expand power",
		"exec": "echo '{\"text\":\"⏻\",\"tooltip\":\"Power\"}'",
		"return-type": "json",
		"on-click": "sudo ~/.config/wlogout/launch.sh"
	}
}
      '';    

      ".config/waybar/style.css".text = ''
* {
	font-family: 'M+1Code Nerd Font';
	
	font-size: 16px;

	color: @theme_fg_color;
}

window#waybar {
	background: transparent;
}

window#waybar > * {
	padding: 10px 10px;
}

.modules-right, .modules-left {
	background-color: rgba(10, 10, 10, 0.5);
	border-radius: 4px;
}

.modules-right > widget > *, .modules-left > widget > * {
	padding: 0 5px;
}

#custom-nix {
	font-size: 20px;
}

#workspaces button {
	padding: 6px 5px;
}

#workspaces button.active label {
	color: @theme_selected_fg_color;
}
      '';
    };
  };
}
