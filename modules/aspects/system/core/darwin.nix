{ lib, ... }: 
{
  den.aspects.system.core = 
    { host }:
    {
      darwin = lib.mkIf (host.env == "physical" && host.distro == "darwin") {
        
      };
    };
}