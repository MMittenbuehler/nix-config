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
    username = "marcel";
    homeDirectory = "/home/marcel";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "marcel@mittenbuehler.com";
    userName = "MMittenbuehler";
  };

  systemd.user.startServices = "sd-switch";

}

