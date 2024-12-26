# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-gpu-nvidia
      inputs.hardware.nixosModules.common-pc-ssd      

      ./hardware-configuration.nix

      ../common/global
      ../common/users/marcel

      ../common/optinoal/pipewire.nix
      ../common/optional/tlp.nix
      ../common/optional/wireless.nix
      ../common/optional/gnome.nix
    ];

  networking.hostName = "xps5960-mmit";

  services.power-profiles-daemon.enable = false;
  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware.graphics.enable = true;
}
