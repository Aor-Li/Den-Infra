{ ... }:
{
  den.aspects.desktop.ghostty =
    { host, ... }:
    {
      homeManager =
        { lib, ... }:
        lib.mkIf (host.graphical or false) {
          programs.ghostty.enable = true;
        };
    };
}
