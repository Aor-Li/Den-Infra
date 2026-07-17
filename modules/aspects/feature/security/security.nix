{ den, ... }:
{
  # 域级 input：secrets 依赖 sops-nix 的 nixos / darwin / home-manager 模块。
  # `nix run .#write-flake` 会把它汇总进根 flake.nix。
  flake-file.inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.security.includes = [
    den.aspects.security.secrets
  ];
}
