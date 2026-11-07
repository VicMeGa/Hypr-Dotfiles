{  config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = false;
 # boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub.enable = true;
  #boot.loader.grub.version = 2;
  #boot.loader.grub.useOSProber = true;
  #boot.loader.grub.device = "/dev/nvme0n1";
  #boot.loader.systemd-boot.editor = false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    settings = {
      default = "@saved";
    };
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.loader.systemd-boot.configurationLimit = 1;


  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  #boot.loader.efi.efiSysMountPoint = "/boot";
  #boot.loader.grub.configurationLimit = 3;
  #boot.loader.grub = {
  #  enable 		= true;
  #  efiSupport 	= true;
  #  useOSProber = true;
  #  configurationLimit = 10; # o quítalo
  #  devices = [ "nodev" ];
  #};
 # boot.loader.grub.devices = [ "nodev" ];
  networking.hostName = "vnix"; # Define your hostname.
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  #zramSwap = {
  #  enable 			= true;
  #  algorithm 		= "zstd";
  #  memoryPercent 	= 60;
  #  priority 		= 100;
  #};


  services.earlyoom = {
    enable           = true;
    freeMemThreshold = 5;   # actúa cuando queda <5% de RAM libre
    freeSwapThreshold = 10;
    enableNotifications = true;
  };

  # OPT: parámetros del kernel para reducir swappiness y presión de caché
  boot.kernel.sysctl = {
    "vm.swappiness"        = 30;   # prefiere RAM sobre swap
    "vm.vfs_cache_pressure" = 50;  # conserva más inodes/dentries en caché
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4096; # 4GB
      priority = 10;
   }
  ];

  #-------- Graficos -------------------------------
  services.xserver.videoDrivers = [ "nvidia" ];

  #hardware.opengl = {
   # enable = true;
    #enable32bit = true;
    #driSupport = true;
    #driSupport32Bit = true;
  #};

  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # 👈 esto es lo correcto en 25.11
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    open = false;
  };
 
  hardware.nvidia.prime = {
    offload.enable = false;
    sync.enable = true;
    #offload.enableOffloadCmd = true;
    amdgpuBusId = "PCI:6:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

 # ------------ Wayland y Hyprland--------------------------------------------
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  xdg.portal = {
   enable = true;
   extraPortals = with pkgs; [
     xdg-desktop-portal-hyprland
   ]; 
  };

 #------------- Display Manager ----------------------
  services.displayManager.ly.enable = true;
  services.displayManager.ly = {
    settings = {
      animate = true;
      animation = 1;  # 0=matrix, 1=disco, 2=nieve, 3=pipes
    };
  };
 #------------- Servicios ---------------------------
  services.dbus.enable = true;
  #services.pam.services.hyprland = true;  
  services.udisks2.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  security.polkit.enable = true;
  
  services.playerctld.enable = true;
  services.upower.enable = true;
  #services.tuned.enable = true;

  services.tailscale = {
    enable = true;
  };
  
  services.asusd = {
    enable = true;
  };
 
  programs.nix-ld.enable = true;
  
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="10c4", MODE="0666", GROUP="dialout"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", MODE="0666", GROUP="dialout"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1a86", MODE="0666", GROUP="dialout"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE="0666", GROUP="dialout"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", ENV{MODE}="0666"
  '';


  #users.users.user.extraGroups = [ "dialout" ];
 #------------- Audio ----------------------------------
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
  };

 # ------------ Base de datos -------------------------
  #services.mysql = {
  #  enable = false;
  #  package = pkgs.mariadb;
  #};
  #systemd.services.mysql.enable = false;

  virtualisation.docker.enable = true;
  #systemd.services.docker.enable = true;
  #systemd.sockets.docker.mask = false;
 # ----------- Experimental -------------------
 nix.settings.experimental-features = [ "nix-command" "flakes" ];

 # ----------- Login / Energia ----------------
  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandlePowerKeyLongPress = "poweroff";
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };

 # ------------ Shell -------------------------------
  programs.fish.enable = true;
  #programs.handlr.enable = true;

  # ---------- Firefox ---------------------------------------------
  programs.firefox.enable = true;
  
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR



  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

 # ------------- ollama -----------------------------------------
# services.ollama = {
#    enable = true;
#    package = pkgs.ollama-cuda; 
#  };
 # ------------- Enviroment pnpm ----------------------------------
  environment.sessionVariables = {
   PNPM_HOME = "$HOME/.local/share/pnpm"; 
  };

environment.extraInit = ''
  export PATH="$PNPM_HOME:$PATH"
'';

 # ------------- Usuario ------------------------------------------
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.user = {
     isNormalUser = true;
     home = "/home/user";
     shell = pkgs.fish;
    # security.sudo.enable = true;
     extraGroups = [ "wheel" 
                     "networkmanager"
                     "docker"
		    "dialout"
                   ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  nix.optimise.automatic = true;
  #--------------------- Paquetes Inseguros Permitidos -----------------------
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
  
 # ------------------- Paquetes del sistema ---------------------------------------------
  # List packages installed in system pnle.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
   # Sistema base
    #vim
    wget
    micro
    coreutils
    xdg-utils
    desktop-file-utils
    git

    fish
    neovim

    #cbonsai

    asusctl
    supergfxctl

    glib

   # Hyprland ecosystem
    hyprland
    waybar
    #hyprpaper
    hyprlock
    hyprshot
    hyprpolkitagent
    wl-clipboard
    wlogout
    rofi

   # Notifications
    swaynotificationcenter 
    libnotify

    gtk3

   # Terminal
    kitty
    #kdePackages.konsole

  # File manager
    #kdePackages.dolphin
    nemo-with-extensions
    adwaita-icon-theme
    ranger

  # Monitores de sistema
    btop
    #nvtopPackages.nvidia
    htop-vim
    #fastfetch
    neofetch
    radeontop

  # Audio / video
    pavucontrol
    pulseaudio
    ffmpeg
    cava
    mpv

  # Fuentes e iconos
    networkmanagerapplet
    font-awesome

  # Temas
    waypaper
    swww
    pywal

  # Aplicaciones
    tidal-hifi
    #librewolf
    vscode
    zed-editor
    obsidian
    discord
    telegram-desktop
    obs-studio
    qview
    libreoffice
    baobab
    bruno
   
    floorp-bin
    thunderbird
   # KDE utils
    #kdePackages.kio
    #kdePackages.kio-fuse #to mount remote filesystems via FUSE
    #kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    #kdePackages.falkon
    #kdePackages.kservice
    #kdePackages.solid
    #kdePackages.filelight
    #kdePackages.gwenview
   
    handlr

  # Desarrollo
    python3
    pipx
    jdk21
    maven
    gradle
    rustup
    gcc
    alsa-lib
    openssl
    pkg-config
    docker
    docker-compose
    nodejs_24
    pnpm
    
    arduino-ide
    arduino-cli
    libusb-compat-0_1
    micronucleus
    usbutils
    awscli2
    #aws-sam-cli
    cargo-lambda

  # Utilidades
    #blender
    zip
    unzip
    unrar
    p7zip
    #tailscale
    #sqlcl
    brightnessctl
    sbctl
    efibootmgr
    
    opencode
    #ollama
    #flatpak

  # Diagnóstico GPU
    mesa-demos
    vulkan-tools
    

  # EMULATOR
    ryubing
  # Trash
    #hyprland-plugins
    #wofi
    #kate
    #notion-app
    #davinci-resolve
    #audacity
    #qtsvg
    #lazydocker

      ]; 

# ---------- FUENTES ----------------- 
fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      font-awesome
      nerd-fonts.symbols-only
      corefonts
    ];

# Agrega este bloque:
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Fira Code" "Symbols Nerd Font" "Font Awesome 6 Free" ];
      sansSerif = [ "Noto Sans" "Symbols Nerd Font" "Font Awesome 6 Free" ];
      serif = [ "Noto Serif" "Symbols Nerd Font" "Font Awesome 6 Free" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
  # --------------------- UNFREE ------------------------
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "vscode"
        "obsidian"
        "unrar"
        "discord"
        "castlabs-electron"
        "nvidia-x11"
        "nvidia-settings"
        #"sqlcl"
	"corefonts"
        #"ollama"
	#"cuda_cudart"  # <-- La que falló ahora
        #"libcublas"    # <-- Probablemente la siguiente
	#"cuda_nvcc"
	#"cuda_cccl"

        #"davinci-resolve"
      ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;0
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
#networking.wireguard.interfaces = {
#  wg0 = {
#    ips = [ "10.2.0.2/32" ];
#    privateKeyFile = "/home/victor/llaves/private.key";#

#    peers = [
#      {
#        publicKey = "E5wPCWdLcrvCn8DI8/vetPVrOyIKFMpdgdhrVsTUdBU=";
#        allowedIPs = [ "0.0.0.0/0" ];
#        endpoint = "45.14.71.5:51820";
#        persistentKeepalive = 25;
#      }
#    ];
#  };
#};

#networking.firewall.checkReversePath = "loose";
#networking.nameservers = [ "10.2.0.1" ];
#services.resolved.enable = true;
# This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}