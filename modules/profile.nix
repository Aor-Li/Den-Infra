# define al hosts + users + homes
{
  # macbook pro
  den.hosts.aarch64-darwin.Magatsumi = {
    env = "physical";
    role = "laptop";
    distro = "darwin";
    users.aor = { };
  };
  den.homes.aarch64-darwin."aor@Magatsumi" = { };

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
}
