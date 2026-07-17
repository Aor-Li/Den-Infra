{ ... }:
{
  den.aspects.desktop.applications.base =
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
