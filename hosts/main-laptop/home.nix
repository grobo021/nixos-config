{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/git.nix
  ];

  home.username = "rishab";
  home.homeDirectory = "/home/rishab";

  home.stateVersion = "24.05"; # DO NOT CHANGE UNLESS YOU ARE VERY CAREFUL

  home.packages = [
    pkgs.hello
    pkgs.discord
    pkgs.mako
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    pkgs.mullvad-browser
    pkgs.wofi
    pkgs.wofi-pass
    pkgs.wofi-emoji
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.telegram-desktop
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
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
