# define al hosts + users + homes
{
  # wsl
  den.hosts.x86_64-linux.Nurari = {
    env = "wsl";
    role = "desktop";
    distro = "nixos";
    users.aor = { };
  };
  den.homes.x86_64-linux."aor@Nurari" = { };

  # macbook pro
  den.hosts.aarch64-darwin.Tamamo = {
    env = "physical";
    role = "laptop";
    distro = "darwin";
    users.aor = { };
  };
  den.homes.aarch64-darwin."aor@Tamamo" = { };

  # mini-pc
  den.hosts.x86_64-linux.Jorogumo = {
    env = "physical";
    role = "server";
    distro = "nixos";
    users.aor = { };
  };
  den.homes.x86_64-linux."aor@Jorogumo" = { };
}
