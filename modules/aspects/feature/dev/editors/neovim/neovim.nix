{ den, ... }:
{
  den.aspects.dev.editors.neovim = {
    # 源仓库有 nvf / nixcat / lazyvim 三套实现 + impl 选择器；本次迁移只保留
    # 默认实现 lazyvim，故去掉选择器，直接包含 lazyvim。
    includes = [ den.aspects.dev.editors.neovim.lazyvim ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          neovim
        ];
      };

    homeManager = {
      programs.neovim = {
        enable = true;
        # to silence warnings after version update
        withRuby = false;
        withPython3 = false;
      };
    };
  };
}
