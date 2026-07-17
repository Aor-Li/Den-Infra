{ inputs, ... }:
{
  flake-file.inputs = {
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.desktop.niri =
    { host, ... }:
    {
      nixos =
        { lib, ... }:
        lib.mkIf (host.graphical or false) {
          programs.niri.enable = true;
        };

      # imports 不能依赖 config，故用 host 上下文（求值期即确定）做静态门控，
      # 避免在 darwin / 无图形环境的主机上引入上游模块触发平台断言。
      homeManager =
        { lib, ... }:
        {
          imports = lib.optionals (host.graphical or false) [
            inputs.niri.homeModules.niri
          ];
        };
    };
}
