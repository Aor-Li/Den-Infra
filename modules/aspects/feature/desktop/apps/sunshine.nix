{ ... }:
{
  den.aspects.desktop.apps.sunshine =
    { host, ... }:
    {
      nixos =
        { lib, ... }:
        lib.mkIf (host.graphical or false) {
          services.sunshine = {
            enable = true;
          };
        };
    };
}
