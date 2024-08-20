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
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
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
