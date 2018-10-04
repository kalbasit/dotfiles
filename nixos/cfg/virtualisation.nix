{ ... }:

{
  # Enable docker support
  virtualisation.docker.enable = true;

  # Enable Virtualbox support
  virtualisation.virtualbox.host.enable = true;

  # install virtualbox extensions pack
  nixpkgs.config.virtualbox.enableExtensionPack = true;
}
