{ config, pkgs, lib, inputs, ... }:

let
  userName = "rishab";
  description = "Rishab Arora";
in 
{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/nixos/main-user.nix
      ../../modules/nixos/secrets-manager.nix
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
      inputs.nixvim.nixosModules.nixvim
      inputs.sops-nix.nixosModules.sops
    ];

  # SOPS Management
  secrets-manager = {
    enable = true;
    inherit userName;
    secretsPath = ./secrets/secrets.yaml;
  };

  # Stylix Theming
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    image = ./wall.png;

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
	name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
	name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
	name = "DejaVu Serif";
      };
    };
  };

  # Nixvim
  programs.nixvim = {
    enable = true;
    plugins.lightline.enable = true;
  };

  # Main User
  main-user = {
    enable = true;
    inherit userName;
    inherit description;
    hashedPasswordFile = config.sops.secrets."users/${userName}".path;
  };

  # Bootloader.
  # boot.loader.systemd-boot = {
  #  enable = true;
  #  extraEntries = {
  #    "grub.conf" = ''
  #       title Linux Mint
  #       linux /EFI/ubuntu/shimx64.efi
  #    '';
  #  };
  # };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    efiSupport = true;
    device = "nodev";
    extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
  };

  # Mount Windows Disk
  fileSystems."/mnt/windows-disk" = {
    device = "/dev/sdb2";
    fsType = "ntfs";
    options = ["nofail" "nosuid" "nodev" "x-gvfs-show"];
  };

  networking.hostName = "main-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
  };

  # Enable Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install fish.
  programs.fish.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
    fira-code-symbols
  ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${userName}" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable GnuPG and Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
    enableSSHSupport = true;
  };

  # System Variables
  environment.sessionVariables = {
    FLAKE = "/etc/nixos";
  };

  # Useful System Packages
  environment.systemPackages = with pkgs; [
    kitty
    wget
    git
    sl
    efibootmgr
    pass
    pinentry-all
    ntfs3g
    btrfs-progs
    gnupg
    wl-clipboard
    sops
    nh
    nix-output-monitor
    nvd
    fastfetch
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
