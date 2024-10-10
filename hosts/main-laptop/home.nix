{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/git.nix
  ];

  home.username = "rishab";
  home.homeDirectory = "/home/rishab";

  home.stateVersion = "24.05"; # DO NOT CHANGE UNLESS YOU ARE VERY CAREFUL

  home.packages = with pkgs; [
    hello
    vesktop
    mako
    wofi
    wofi-pass
    wofi-emoji
    playerctl
    brightnessctl
    telegram-desktop
    protonup
  ] ++ [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Firefox
  programs.firefox = {
    enable = true;
  };

  # Enable FISH Shell
  programs.fish.enable = true;
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
