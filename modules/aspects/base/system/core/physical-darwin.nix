{ lib, ... }:
{
  den.aspects.system.core.physical-darwin =
    { host, ... }:
    {
      darwin = lib.mkIf (host.env == "physical" && host.distro == "darwin") { };
    };
}
