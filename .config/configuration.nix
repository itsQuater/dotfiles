# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  # Change if nvme drive
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luna = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Luna";/
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  #i3 conf
  services = {
    xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
	extraPackages = with pkgs; [
          i3blocks
	];
      };
      displayManager = {
        gdm.enable = true;
	defaultSession = "none+i3";
      };
    };
    desktopManager = {
       plasma6.enable = true;
    };
  };

  # Delete default KDE packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  # Nvidia drivers - uncoment if needed.
  #hardware.graphics = {
  #  enable = true;/
  #};
  #services.xserver.videoDrivers = ["nvidia"];
  #hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = true;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #};

  #ZSH shell config
  programs.zsh = {
     enable = true;
     enableCompletion = true;
     autosuggestions.enable = true;
     syntaxHighlighting.enable = true;
     shellAliases = {
        update = "sudo nixos-rebuild switch";
	ff = "fastfetch";
     };
     ohMyZsh = {
        enable = true;
        plugins = [ "git" "z" ];
        theme = "robbyrussell";
     };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Pulseaudio
  nixpkgs.config.pulseaudio = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     fastfetch
     librewolf
     vlc
     gimp
     kitty
     rofi
     spotify
     discord
     feh
     wine
     clamav
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}


# https://github.com/linavixx/i3rice-eos/tree/main?tab=readme-ov-file
# https://www.reddit.com/r/linuxmemes/comments/10w3ke1/the_life_of_a_thinkpad/
# https://www.reddit.com/r/LinuxCirclejerk/comments/1fewiq1/average_linux_user/