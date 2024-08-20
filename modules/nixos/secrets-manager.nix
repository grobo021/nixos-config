{ lib, config, pkgs, ... }:

let
  cfg = config.secrets-manager;
in {
  options.secrets-manager = {
    enable = lib.mkEnableOption "enable secrets manager module";
    
    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        user name
      '';
    };

    secretsPath = lib.mkOption {
      default = ../../secrets/secrets.yaml;
      description = ''
        Path to secrets
      '';
    };
  };

  config.sops = lib.mkIf cfg.enable {
    defaultSopsFile = cfg.secretsPath;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${cfg.userName}/.config/sops/age/keys.txt";

    secrets = {
      "users/${cfg.userName}" = {
         neededForUsers = true;
      };
    };
  };
}
