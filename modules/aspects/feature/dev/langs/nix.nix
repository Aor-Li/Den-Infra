{ ... }:
{
  den.aspects.dev.langs.nix.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.nil
        pkgs.nixfmt
        pkgs.statix
      ];
    };
}
