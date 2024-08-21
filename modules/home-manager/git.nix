{ lib, config, pkgs, ... }:

{
  options = {};

  config = {
    programs.git = {
      enable = true;
      userEmail = "29125087+grobo021@users.noreply.github.com";
      userName = "grobo021";
    };

    programs.gh = {
      enable = true;
      package = pkgs.gitAndTools.gh;
      gitCredentialHelper.enable = true;
    };
  };
}
