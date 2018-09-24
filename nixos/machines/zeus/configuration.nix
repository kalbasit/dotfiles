{ config, pkgs, lib, ... }:

{
  # Include the results of the hardware scan.
  imports = [
    <nixos-hardware/common/cpu/intel>
    <nixos-hardware/common/pc/laptop>
    <nixos-hardware/common/pc/laptop/ssd>

    ./hardware-configuration.nix

    ../../cfg/common.nix
    ../../cfg/virtualisation.nix
    ../../cfg/redshift.nix

    ../../cfg/snapper.nix
  ];

  # boot the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Start an SSH server within initrd
  boot.initrd.network = {
    ssh = {
      authorizedKeys = [
        (builtins.readFile (builtins.fetchurl {
          url = "https://github.com/kalbasit.keys";
          sha256 = "1jm3haqcv827vr92ynkbf23dgq0anlym10hqk87wbzafb82smy50";
        }))
      ];

      enable = true;
      hostRSAKey = builtins.readFile zeus_initrd_ssh_host_rsa_key_path;
    };
  };

  # Define your hostname.
  networking.hostName = "zeus";

  # select a console font
  i18n.consoleFont = "Lat2-Terminus16";
  boot.earlyVconsoleSetup = true;

  # put /tmp on tmpfs
  boot.tmpOnTmpfs = true;

  # List services that you want to enable:

  # enable nix-serve
  services.nix-serve = lib.mkIf (builtins.pathExists /private/network-secrets/nix/caches/zeus.nasreddine.com.key) {
    enable = true;
    secretKeyFile = "/private/network-secrets/nix/caches/zeus.nasreddine.com.key";
  };
  networking.firewall.allowedTCPPorts = lib.mkIf (builtins.pathExists /private/network-secrets/nix/caches/zeus.nasreddine.com.key) [ 5000 ];

  # Enable fwupd
  services.fwupd.enable = true;

  # set the video drivers to modesetting so no other drivers are loaded
  services.xserver.videoDrivers = lib.mkForce ["modesetting"];

  # configure OpenSSH server to listen on the ADMIN interface
  services.openssh.listenAddresses = [ { addr = "172.25.250.3"; port = 22; } ];

  #
  # Network
  #

  # enable DHCP forcibly as it is required for initrd
  networking.useDHCP = lib.mkForce true;

  # disable the networkmanager on Zeus as it is really not needed since the
  # network does never change.
  networking.networkmanager.enable = lib.mkForce false;

  networking.vlans = {
    ifcns1 = {
      id = 101;
      interface = "enp2s0f0";
    };

    ifcns2 = {
      id = 102;
      interface = "enp2s0f1";
    };

    ifcns3 = {
      id = 103;
      interface = "enp4s0f0";
    };

    ifcns4 = {
      id = 104;
      interface = "enp4s0f1";
    };

    ifcadmin = {
      id = 250;
      interface = "enp0s31f6";
    };
  };

  networking.interfaces = {
    # turn off DHCP on all real interfaces, I use virtual networks.
    enp2s0f0 = { useDHCP = false; };
    enp2s0f1 = { useDHCP = false; };
    enp4s0f0 = { useDHCP = false; };
    enp4s0f1 = { useDHCP = false; };
    enp0s31f6 = { useDHCP = false; };

    # The ADMIN interface
    ifcadmin = {
      useDHCP = true;
    };

    # NS1 address
    ifcns1 = {
      useDHCP = true;
    };

    # NS2 address
    ifcns2 = {
      useDHCP = true;
    };

    # NS3 address
    ifcns3 = {
      useDHCP = true;
    };

    # NS4 address
    ifcns4 = {
      useDHCP = true;
    };
  };
}
