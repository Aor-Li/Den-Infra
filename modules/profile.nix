# define al hosts + users + homes
{
  #####################
  ### System + Home ###
  #####################

  # main nixos pc
  den.hosts.x86_64-linux.Enten = {
    env = "physical";
    role = "desktop";
    distro = "nixos";
    users.aor = { };
  };
  den.homes.x86_64-linux."aor@Enten" = { };

  # macbook pro
  den.hosts.aarch64-darwin.Magatsumi = {
    env = "physical";
    role = "laptop";
    distro = "darwin";
    users.aor = { };
  };
  den.homes.aarch64-darwin."aor@Magatsumi" = { };

  # mackbook pro - nixos vm
  den.hosts.aarch64-linux.Kuregumo = {
    env = "virtual";
    role = "laptop";
    distro = "nixos";
    users.aor = { };
  };
  den.homes.aarch64-linux."aor@Kuregumo" = { };

  # wsl
  den.hosts.x86_64-linux.Kumeyuri = {
    env = "wsl";
    role = "desktop";
    distro = "nixos";
    users.aor = { };
  };
  den.homes.x86_64-linux."aor@Kumeyuri" = { };

  # mini-pc
  den.hosts.x86_64-linux.Tobimune = {
    env = "physical";
    role = "server";
    distro = "nixos";
    users.aor = { };
  };
  den.homes.x86_64-linux."aor@Tobimune" = { };

  ############################################
  ### Standard Alone Home-Manager Profiles ###
  ############################################
  den.homes.x86_64-linux."aor@philo" = { };
}
