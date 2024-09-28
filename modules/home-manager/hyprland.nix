{ lib, config, ... }:

{
  options = {};

  config = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
	"$terminal" = "kitty";
	"$browser" = "mullvad-browser";
	"$menu" = "wofi --show drun";
	# "$filemanager" = "dolphin";

	bind = [
	  # Common Keybinds
          "$mod, Q, exec, $terminal"
	  "$mod, C, killactive, "
	  "$mod, M, exit, "
          # "$mod, E, exec, $fileManager"
	  "$mod, V, togglefloating, "
	  "$mod, B, exec, $browser"
	  ", Print, exec, grimblast copy area"
	  "$mod, R, exec, $menu"
	  "$mod, P, pseudo, "
	  "$mod, J, togglesplit, "

	  # Scratchpad/Special Workspace
	  "$mod, S, togglespecialworkspace, magic"
	  "$mod SHIFT, S, movetoworkspace, special:magic"

	  # Scroll workspaces with $mod + scroll
	  "$mod, mouse_down, workspace, e+1"
	  "$mod, mouse_up, workspace, e-1"
	] ++ (
	  # Workspaces
          builtins.concatLists(builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}" # $mod + [0-9] to change workspace
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}" # $mod + shift + [0-9] to move window to another workspace
              ]
            ) 9
	  )
        );

        # Move/resize windows with mainMod + LMB/RMB and dragging
	bindm = [
	  "$mod, mouse:272, movewindow"
	  "$mod, mouse:273, resizewindow"
	];

	# Laptop multimedia keys for volume and LCD brightness
	bindel = [
	  ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
   	  ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	  ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	  ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
	  ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
	  ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
	];

	bindl = [
          ", XF86AudioNext, exec, playerctl next"
	  ", XF86AudioPause, exec, playerctl play-pause"
	  ", XF86AudioPlay, exec, playerctl play-pause"
	  ", XF86AudioPrev, exec, playerctl previous"
	];

	monitor = [
          "HDMI-A-1, preffered, auto, 1"
	  "eDP-1, preffered, auto, 1, mirror, HDMI-A-1"
	];

	windowrulev2 = [
	  "suppressevent maximize, class:.*"
	];
      };
    };
  };
}
