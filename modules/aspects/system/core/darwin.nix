{ lib, ... }:
{
  den.aspects.system.includes = [
    (
      { host, ... }:
      {
        darwin = lib.mkIf (host.env == "physical" && host.distro == "darwin") {

        };
      }
    )
  ];
}
