{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # users.mutableUsers = false;
  users.users.marcel = {
    isNormalUser = true;
    description = "Marcel Mittenbuehler";
    extraGroups = ifTheyExist [
      "audio"
      "deluge"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "minecraft"
      "mysql"
      "network"
      "plugdev"
      "podman"
      "video"
      "wheel"
      "wireshark"
      "networkmanager"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/marcel/ssh.pub);
    # hashedPasswordFile = config.sops.secrets.marcel-passwd.path;
    packages = [pkgs.home-manager];
  };

  home-manager.users.marcel = import ../../../../home/marcel/${config.networking.hostName}.nix;
  
  sops.secrets.marcel-passwd = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };
}
