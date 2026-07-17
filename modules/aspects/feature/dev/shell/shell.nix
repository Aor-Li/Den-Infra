{ den, ... }:
{
  den.aspects.dev.shell = {
    includes = [
      den.aspects.dev.shell.starship
      den.aspects.dev.shell.tmux
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          bash
          fish
        ];
      };

    homeManager = {
      programs.bash.enable = true;
      programs.fish.enable = true;

      # 确保一些 TUI 程序色彩显示正常（原 feature/system/shell.nix，迁 dev 时并入此处）
      home.sessionVariables.COLORTERM = "truecolor";
      systemd.user.sessionVariables.COLORTERM = "truecolor";
    };
  };
}
