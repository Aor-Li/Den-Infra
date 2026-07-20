{ den, ... }:
{
  den.aspects.aor.includes = [
    den.provides.primary-user
    (den.batteries.user-shell "fish")
  ];
}
