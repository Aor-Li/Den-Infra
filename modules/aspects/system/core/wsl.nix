{ inputs, lib, ... }:
{
  flake-file.inputs = {
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.system.core =
    { host, user }:
    {
      nixos = lib.mkIf (host.env == "wsl" && host.distro == "nixos") {
        imports = [ inputs.nixos-wsl.nixosModules.wsl ];
        wsl = {
          enable = true;
          useWindowsDriver = true;
          startMenuLaunchers = true;
          defaultUser = user.userName;

          wslConf.automount.root = "/mnt";
          wslConf.network.hostname = host.hostName;
        };

        # boot.loader.systemd-boot.enable = false;
        # boot.loader.efi.canTouchEfiVariables = false;
      };
    };
}

