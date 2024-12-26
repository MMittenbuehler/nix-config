# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix-ld.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
    ./systemd-boot.nix
    ./systemd-initrd.nix
    ./upower.nix
  ]; # ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

#   # Bootloader.
#   boot.loader.systemd-boot.enable = true;
#   boot.loader.efi.canTouchEfiVariables = true;

#   # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

#   # Configure network proxy if necessary
#   # networking.proxy.default = "http://user:password@proxy:port/";
#   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

#   # Enable networking
#   networking.networkmanager.enable = true;

#   # Enable the X11 windowing system.
#   services.xserver.enable = true;

#   # Enable the GNOME Desktop Environment.
#   services.xserver.displayManager.gdm.enable = true;
#   services.xserver.desktopManager.gnome.enable = true;

#   # Configure keymap in X11
#   services.xserver.xkb = {
#     layout = "de";
#     variant = "";
#   };

#   # Configure console keymap
#   console.keyMap = "de";

#   # Enable CUPS to print documents.
#   services.printing.enable = true;
#   services.printing.drivers = [
#     pkgs.epson-escpr
#     pkgs.epson-escpr2
#   ];

#   services.avahi = { enable = true; nssmdns4 = true; };

#   # Enable sound with pipewire.
#   hardware.pulseaudio.enable = false;
#   security.rtkit.enable = true;
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#     # If you want to use JACK applications, uncomment this
#     #jack.enable = true;

#     # use the example session manager (no others are packaged yet so this is enabled by default,
#     # no need to redefine it in your config for now)
#     #media-session.enable = true;
#   };

#   # Enable touchpad support (enabled default in most desktopManager).
#   # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.segger-jlink.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
                "segger-jlink-qt4-796s"
    "electron-27.3.11" # required by logseq
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    freecad-wayland
    wget
    nextcloud-client
    thunderbird
    vscode
    jetbrains.clion
    kicad
    brave
    firefox
    discord
    kitty
    keepassxc
    tigervnc
    git
    zoom-us
    gnomeExtensions.nextcloud-folder
    epson-escpr
    epson-escpr2
    libreoffice
    sshfs
    qt5.qtwayland
    logseq
    discord
    freecad
    platformio
    python310
    nrf-command-line-tools
    nrfutil
    nrfconnect
    usbutils
    segger-jlink
  ];

  programs.bash.shellAliases = {
    vim = "nvim";
  };

#   #environment.sessionVariables.QT_QPA_PLATFORM = "wayland";


#   # Some programs need SUID wrappers, can be configured further or are
#   # started in user sessions.
#   # programs.mtr.enable = true;
#   # programs.gnupg.agent = {
#   #   enable = true;
#   #   enableSSHSupport = true;
#   # };

  
#   # Disable the GNOME3/GDM auto-suspend feature that cannot be disabled in GUI!
#   # If no user is logged in, the machine will power down after 20 minutes.
#   systemd.targets.sleep.enable = true;
#   systemd.targets.suspend.enable = true;
#   systemd.targets.hibernate.enable = false;
#   systemd.targets.hybrid-sleep.enable = false;

#   # List services that you want to enable:

#   # Open ports in the firewall.
#   networking.firewall.allowedTCPPorts = [ 22 ];
#   # networking.firewall.allowedUDPPorts = [ ... ];
#   # Or disable the firewall altogether.
#   networking.firewall.enable = true;

#   # This value determines the NixOS release from which the default
#   # settings for stateful data, like file locations and database versions
#   # on your system were taken. It‘s perfectly fine and recommended to leave
#   # this value at the release version of the first install of this system.
#   # Before changing this value read the documentation for this option
#   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
#   system.stateVersion = "unstable"; # Did you read the comment?

#   services.udev.packages = [
#     (pkgs.writeTextFile {
#       name = "segger_udev";
#       text = ''
# #ACTION!="add", SUBSYSTEM!=="usb_device", GOTO="jlink_rules_end"
# #
# # Give all users read and write access.
# # Note: NOT all combinations are supported by J-Link right now. Some are reserved for future use, but already added here
# #
# # 0x0101 - J-Link (default)
# # 0x0102 - J-Link USBAddr = 1 (obsolete) 
# # 0x0103 - J-Link USBAddr = 2 (obsolete) 
# # 0x0104 - J-Link USBAddr = 3 (obsolete) 
# # 0x0105 - CDC + J-Link
# # 0x0106 - CDC
# # 0x0107 - RNDIS  + J-Link
# # 0x0108 - J-Link + MSD
# # 0x1000 - MSD
# #
# ATTR{idProduct}=="0101", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="0102", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="0103", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="0104", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="0105", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="0107", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="0108", ATTR{idVendor}=="1366", MODE="666"
# #
# # 0x1000 not added yet
# #
# # New PID scheme, for all possible combinations
# # 0x1001: MSD
# # 0x1002: RNDIS
# # 0x1003: RNDIS  + MSD
# # 0x1004: CDC
# # 0x1005: CDC    + MSD
# # 0x1006: RNDIS  + CDC
# # 0x1007: RNDIS  + CDC    + MSD
# # 0x1008: HID
# # 0x1009: MSD    + HID
# # 0x100a: RNDIS  + HID
# # 0x100b: RNDIS  + MSD    + HID
# # 0x100c: CDC    + HID
# # 0x100d: CDC    + MSD    + HID
# # 0x100e: RNDIS  + CDC    + HID
# # 0x100f: RNDIS  + CDC    + MSD + HID
# # 0x1010: J_LINK
# # 0x1011: J_LINK + MSD
# # 0x1012: RNDIS  + J_LINK
# # 0x1013: RNDIS  + J_LINK + MSD
# # 0x1014: CDC    + J_LINK
# # 0x1015: CDC    + J_LINK + MSD
# # 0x1016: RNDIS  + CDC    + J_LINK
# # 0x1017: RNDIS  + CDC    + J_LINK + MSD
# # 0x1018: J_LINK + HID
# # 0x1019: J_LINK + MSD    + HID
# # 0x101a: RNDIS  + J_LINK + HID
# # 0x101b: RNDIS  + J_LINK + MSD    + HID
# # 0x101c: CDC    + J_LINK + HID
# # 0x101d: CDC    + J_LINK + MSD    + HID
# # 0x101e: RNDIS  + CDC    + J_LINK + HID
# # 0x101f: RNDIS  + CDC    + J_LINK + MSD + HID
# #
# # 0x1001 - 0x100f not added yet
# #
# ATTR{idProduct}=="1010", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1011", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1012", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1013", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1014", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1015", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1016", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1017", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1018", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1019", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="101A", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="101B", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="101C", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="101D", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="101E", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="101F", ATTR{idVendor}=="1366", MODE="666"
# ATTR{idProduct}=="1051", ATTR{idVendor}=="1366", MODE="666"
# #
# # End of list
# #
# #LABEL="jlink_rules_end"
#              '';
#       destination = "/etc/udev/rules.d/99-jlink.rules";
#     })
#     (pkgs.writeTextFile {
#       name = "nrf1_udev";
#       text = ''
# # 71-nrf.rules
# ACTION!="add", SUBSYSTEM!="usb_device", GOTO="nrf_rules_end"

# # Set /dev/bus/usb/*/* as read-write for all users (0666) for Nordic Semiconductor devices
# SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", MODE="0666"

# # Flag USB CDC ACM devices, handled later in 99-mm-nrf-blacklist.rules
# # Set USB CDC ACM devnodes as read-write for all users
# KERNEL=="ttyACM[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1915", MODE="0666", ENV{NRF_CDC_ACM}="1"

# LABEL="nrf_rules_end"
#              '';
#       destination = "/etc/udev/rules.d/71-nrf.rules";
#     })
#     (pkgs.writeTextFile {
#       name = "nrf2_udev";
#       text = ''
# # 99-modemmmanager-acm-fix.rules
# # Previously flagged nRF USB CDC ACM devices shall be ignored by ModemManager
# ENV{NRF_CDC_ACM}=="1", ENV{ID_MM_CANDIDATE}="0", ENV{ID_MM_DEVICE_IGNORE}="1"
#              '';
#       destination = "/etc/udev/rules.d/99-mm-nrf-blacklist.rules";
#     })
#   ];

}
