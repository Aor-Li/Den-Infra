{ den, lib, ... }:
let
  common.nix.settings = {
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
in
{
  den.aspects.nix =
    { ... }:
    {
      nixos = lib.recursiveUpdate common {
        nix.settings.trusted-users = [ "@wheel" ];
        nixpkgs.config.allowUnfree = true;
      };

      darwin = lib.recursiveUpdate common {
        nix.settings.trusted-users = [ "@admin" "@wheel" ];
        nixpkgs.config.allowUnfree = true;
      };

      homeManager =
        { pkgs, ... }:
        lib.recursiveUpdate common {
          # standalone home-manager needs an explicit nix package to write nix.conf
          nix.package = pkgs.nix;
          nixpkgs.config.allowUnfreePredicate = _: true;
        };
    };

  den.default.includes = [ den.aspects.nix ];
}
