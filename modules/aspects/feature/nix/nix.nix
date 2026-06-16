{ den, ... }:
{
  den.aspects.nix.includes = with den.aspects.nix; [
    settings
    home-manager
  ];
}