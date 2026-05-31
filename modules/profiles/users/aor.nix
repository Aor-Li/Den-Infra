{ den, ... }:
{
  den.aspects.aor = {
    includes = [
      den.batteries.define-user
      den.batterise.primary-user
      (den.batteries.user-shell "fish")
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.htop ];
      };
  };
}
