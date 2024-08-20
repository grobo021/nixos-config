{ lib, config, ... }:

{
  options = {};

  config = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
	"$terminal" = "kitty";
	"$browser" = "firefox";

	bind = [
          "$mod, Q, exec, $terminal"
	  "$mod, B, exec, $browser"
	  ", Print, exec, grimblast copy area"
	];

	monitor = [
          "HDMI-A-1, preffered, auto, 1"
	  "eDP-1, preffered, auto, 1, mirror, HDMI-A-1"
	];
      };
    };
  };
}
