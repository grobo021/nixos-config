{ lib, config, ... }:

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
      gitCredentialHelper.enable = true;
    };
  };
}
