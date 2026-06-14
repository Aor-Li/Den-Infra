{ lib, ... }:
{
  den.aspects.system.physical-nixos =
    { host, ... }:
    {
      nixos = lib.mkIf (host.env == "physical" && host.distro == "nixos") {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
      };
    };
}
