{ den, ... }:
{
  den.aspects.system.hostname = 
    { host, ... }:
    {
      nixos.networking.hostName  = host.name;

      darwin = {
        networking.hostName      = host.name;
        networking.computerName  = host.name;
        networking.localHostName = host.name;
      };
    };
}