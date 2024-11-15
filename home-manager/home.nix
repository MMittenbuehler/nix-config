{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "mmittenbuehler";
    homeDirectory = "/home/mmittenbuehler";
  }

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

