{ den, ... }:
{
  den.aspects.system.core.includes = [
    den.aspects.system.core.physical-nixos
    den.aspects.system.core.physical-darwin
    den.aspects.system.core.wsl-nixos
  ];
}