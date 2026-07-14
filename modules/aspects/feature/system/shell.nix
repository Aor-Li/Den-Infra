{ ... }:
{
  # TODO: 迁移 feature/dev 时考虑合并进 feature/dev/shell.nix，
  # 目前 dev 域尚未迁移，先独立放在 system 下。
  den.aspects.system.shell.homeManager =
    { ... }:
    {
      # 确保一些TUI程序色彩显示正常
      home.sessionVariables.COLORTERM = "truecolor";
      systemd.user.sessionVariables.COLORTERM = "truecolor";
    };
}
