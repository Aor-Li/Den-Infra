{ inputs, lib, ... }:
{
  flake-file.inputs = {
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  # TODO： 1.wsl需要拆分user; 2. 移动到更合适的位置
  den.aspects.system.core =
    { host, user }:
    {
      nixos =
        { ... }:
        let
          wslHost = host.env == "wsl" && host.distro == "nixos";
        in
        {
          imports = lib.optionals wslHost [ inputs.nixos-wsl.nixosModules.wsl ];
        }
        // lib.optionalAttrs wslHost {
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

