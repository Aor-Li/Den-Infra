{ lib, ... }:
{
  den.aspects.system.physical-darwin =
    { host, ... }:
    {
      darwin = lib.mkIf (host.env == "physical" && host.distro == "darwin") { };
    };
}
