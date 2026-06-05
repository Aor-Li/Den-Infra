{ den, ... }:
{
  den.aspects.system.core = {
    includes = [
      den.aspects.system.core.boot-loader
      den.aspects.system.core.wsl
    ];
  };
}
