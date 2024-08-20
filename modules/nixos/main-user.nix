{ lib, config, pkgs, ...  }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable main user module";
   
    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };

    description = lib.mkOption {
      default = "main user";
      description = ''
        user description
      '';
    };

    hashedPasswordFile = lib.mkOption {
      description = ''
        hashed password file of the user
      '';
    };
  };

  config = lib.mkIf config.main-user.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      hashedPasswordFile = cfg.hashedPasswordFile;
      description = cfg.description;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.fish;
    };  
  };
}
