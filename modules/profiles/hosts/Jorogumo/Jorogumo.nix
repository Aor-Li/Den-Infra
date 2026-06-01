{ den, ... }:
{
  den.aspects.Jorogumo = {
    env = "physical";
    role = "server";
    distro = "nixos";

    includes = [
      den.aspects.system
    ];
  };
}
