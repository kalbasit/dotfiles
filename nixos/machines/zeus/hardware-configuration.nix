# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/12ada2e7-bdfe-4bdf-9335-bc26d7404a10";
    };

    cryptroot-1 = {
      device = "/dev/disk/by-uuid/0f379615-7381-4f40-8e34-4eb930a85f9d";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptroot-2 = {
      device = "/dev/disk/by-uuid/b6f30e7a-d1f2-43bb-825f-77c0c8f0f435";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptswap = {
      device = "/dev/disk/by-uuid/509f93b9-65cb-4886-b6eb-797697373a7d";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptstorage = {
      device = "/dev/disk/by-uuid/1bb05e34-5aa0-419b-a6c0-2574b7566832";
      keyFile = "/dev/mapper/cryptkey";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/471c4bf2-14c9-4eef-a791-8beebfcfe31a";
      fsType = "btrfs";
      options = [ "subvol=@nixos/@root" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/471c4bf2-14c9-4eef-a791-8beebfcfe31a";
      fsType = "btrfs";
      options = [ "subvol=@nixos/@home" ];
    };

    "/code" = {
      device = "/dev/disk/by-uuid/471c4bf2-14c9-4eef-a791-8beebfcfe31a";
      fsType = "btrfs";
      options = [ "subvol=@code" ];
    };

    "/private" = {
      device = "/dev/disk/by-uuid/471c4bf2-14c9-4eef-a791-8beebfcfe31a";
      fsType = "btrfs";
      options = [ "subvol=@private" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/BE41-BF8C";
      fsType = "vfat";
    };
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f58da878-7e18-430e-ad8c-321f63c61a4e"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
