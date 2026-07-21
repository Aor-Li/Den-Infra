{ den, lib, ... }:
{
  den.aspects.system.core.nix =
    { host, ... }:
    {
      nixos = lib.mkIf (host.env == "physical") {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
      };
    };

  den.aspects.system.core.includes = [ den.aspects.system.core.nix ];
}
