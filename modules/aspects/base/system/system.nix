{ den, ... }:
{
  den.aspects.system =
    { ... }:
    {
      includes = [
        den.aspects.system.core
        den.aspects.system.hostname
      ];
    };
}
