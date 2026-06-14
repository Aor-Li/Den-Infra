{ inputs, lib, ... }:
{
  flake-file.inputs = {
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.system.wsl-nixos =
    { host, ... }:
    {
      nixos = {
        imports = [ inputs.nixos-wsl.nixosModules.wsl ];

        wsl = lib.mkIf (host.env == "wsl" && host.distro == "nixos") {
          enable = true;
          useWindowsDriver = true;
          startMenuLaunchers = true;

          wslConf.automount.root = "/mnt";
          wslConf.network.hostname = host.hostName;

          defaultUser = lib.head (lib.attrNames host.users);
        };
      };
    };
}
