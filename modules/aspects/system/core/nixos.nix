{ lib, ... }:
{
  den.aspects.system.core = 
    {host}:
    {
      nixos = lib.mkIf (host.env == "physical" && host.distro == "nixos") {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
      };
    };
}