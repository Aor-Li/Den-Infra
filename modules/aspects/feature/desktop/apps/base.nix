{ ... }:
{
  den.aspects.desktop.apps.base =
    { host, ... }:
    {
      homeManager =
        { lib, pkgs, ... }:
        lib.mkIf (host.graphical or false) {
          home.packages = with pkgs; [
            imagemagick
          ];
        };
    };
}
