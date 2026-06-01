{ den, ... }:
{
  den.aspects.Nurari = {
    env = "wsl";
    type = "desktop";
    distro = "nixos";
    
    includes = [
      den.aspects.system
    ];
  };
}
