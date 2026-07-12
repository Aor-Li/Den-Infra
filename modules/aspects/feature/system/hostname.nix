{ den, ... }:
{
  den.aspects.system.hostname = 
    { host, ... }:
    {
      nixos.networking = {
        hostName  = host.name;
      };
      
      darwin.networking = {
        hostName      = host.name;
        computerName  = host.name;
        localHostName = host.name;
      };
    };
}