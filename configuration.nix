# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true; # Easiest to use. Most distros use by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  
  services.xserver.displayManager = {
    lightdm.enable = true;
    autoLogin = {
      enable = true;
      user = "clay";
    };
  };

  #Enable the LXQT Desktop Environment
#  services.xserver.desktopManager.lxqt.enable = true;
  
  # Enable i3 window manager
  services.xserver.windowManager = {
    i3.enable = true;
#    dwm.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.clay = {
    isNormalUser = true;
    description = "clay";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tmux
    mlocate
    htop
    neofetch
    openssh
    git
#    plocate
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
#  environment.shellAliases = {
#    ls = "ls -lha";
#    nrb = "sudo nixos-rebuild switch";
#    ncf = "sudo nano /etc/nixos/configuration.nix";
#  };
  programs.bash.shellAliases = {
    ls = "ls -lha";
    nrb = "sudo nixos-rebuild switch";
    ncf = "sudo nano /home/clay/.dotfiles/configuration.nix";
  };
 
  # mlocate / plocate
#  services.locate.locate = pkgs.mlocate;
#  services.locate.enable = true;

  services.locate = {
    locate = pkgs.mlocate;
    enable = true;
    interval = "hourly";
  };

  # https://github.com/srid/nixos-config/blob/master/home/tmux.nix
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
