{ lib, ... }:
{
  den.aspects.system.core.boot-loader =
    { host }:
    {
      nixos = lib.mkIf (host.env == "physical") {
        boot-loader.systemd-boot.enable = true;
        boot-loader.efi.canTouchEfiVariables = true;
      };

      darwin = lib.mkIf (host.env == "physical") {
        # currently no boot control in darwin
      };
    };
}
