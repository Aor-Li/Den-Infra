{ den, lib, ... }:
let
  # nix.conf entries shared by system (nixos/darwin) and standalone home-manager
  nixConf.nix.settings = {
    experimental-features = lib.mkDefault [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];

    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  # system-only: allow unfree at the system level + daemon trusted-users
  system =
    trusted-users:
    lib.recursiveUpdate nixConf {
      nix.settings.trusted-users = trusted-users;
      nixpkgs.config.allowUnfree = true;
    };
in
{
  den.aspects.nix =
    { ... }:
    {
      nixos = system [ "@wheel" ];
      darwin = system [
        "@admin"
        "@wheel"
      ];

      homeManager =
        { pkgs, ... }:
        lib.recursiveUpdate nixConf {
          # standalone home-manager needs an explicit nix package to write nix.conf
          nix.package = pkgs.nix;
          nixpkgs.config.allowUnfreePredicate = _: true;
        };
    };

  den.default.includes = [ den.aspects.nix ];
}
