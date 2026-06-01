{ den, ... }:
{
  den.aspects.Tamamo = {
    env = "physical";
    role = "laptop";
    distro = "darwin";
    
    includes = [
      den.aspects.system
    ];
  };
}
