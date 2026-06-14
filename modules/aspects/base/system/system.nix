{ den, ... }:
{
  den.aspects.system =
    { ... }:
    {
      includes = [
        den.aspects.system.physical-nixos
        den.aspects.system.physical-darwin
        den.aspects.system.wsl-nixos
      ];
    };
}
