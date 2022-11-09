# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jlap"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";
  # time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp60s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true; 

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # https://nixos.wiki/wiki/Command_Shell#Changing_default_shell
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jbrock = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # https://discourse.nixos.org/t/dont-prompt-a-user-for-the-sudo-password/9163
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    neovim
    gnome.gnome-tweaks
    docker
    git
    google-chrome
    vscode    
    gnomeExtensions.gtile
    # gnomeExtensions.system-monitor-next
    gnomeExtensions.resource-monitor
    gnomeExtensions.keyboard-backlight-slider
    cachix
    zoom-us
    skypeforlinux
    webcamoid
    # https://discourse.nixos.org/t/override-systempackages-dependencies/20348/2
    gnome.networkmanager-l2tp
    # (gnome.networkmanager-l2tp.override {
    # strongswan = pkgs.strongswan.overrideAttrs (old: {
    #   postInstall = ''
    #     # this is needed for l2tp
    #     echo "include /etc/ipsec.d/*.secrets" >> $out/etc/ipsec.secrets
    #     '';
    # });
    # })
    networkmanagerapplet
    libreoffice
    fish
    powerline-go
    powerline-fonts
    nix-tree
    htop
    spotify
  ];

  # # 2022-07-14
  # # Need this for XC VPN:
  # # echo 'include /etc/ipsec.d/*.secrets' > /etc/ipsec.secrets
  # # https://github.com/NixOS/nixpkgs/blob/8eb14e7e79d6c34a9cce146182bfc8c820d527c2/pkgs/tools/networking/strongswan/default.nix#L100
  # nixpkgs.overlays = [
  # (self: super: {
  #   strongswan = super.strongswan.overrideAttrs (old: rec {
  #     postInstall = ''
  #     # this is needed for l2tp
  #     echo "include /etc/ipsec.d/*.secrets" >> $out/etc/ipsec.secrets
  # '';
  #   });
  # }) 
  # ];

  # https://nixos.wiki/wiki/Fish
  programs.fish.enable = true;

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

  # https://blog.stigok.com/2019/12/09/nixos-avahi-publish-service.html
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
      workstation = true;
      };
    };

  # https://discourse.nixos.org/t/using-experimental-nix-features-in-nixos-and-when-they-will-land-in-stable/7401/4
  nix = {
     package = pkgs.nixFlakes;
     extraOptions = # lib.optionalString (config.nix.package == pkgs.nixFlakes)
       "experimental-features = nix-command flakes";
  };
  # nix.extraOptions = "experimental-features = nix-command";
  
  # 2022-07-14
  # change the backlight timeout from 10s to 10m:
  # https://www.dell.com/support/kbdoc/en-us/000177038/how-to-configure-the-keyboard-backlight-time-out-interval-in-ubuntu-linux?lwp=rt
  
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
  system.stateVersion = "21.11"; # Did you read the comment?

}

