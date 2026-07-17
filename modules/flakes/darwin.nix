{
  # input 必须名为 `darwin`：den 的 host 构建器默认取 `inputs.darwin.lib.darwinSystem`
  # 来构造 distro = "darwin" 的主机（仓库名是 nix-darwin，input 名是 darwin）。
  # den 直接调用该 lib，无需 import flakeModule。
  flake-file.inputs = {
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
}
