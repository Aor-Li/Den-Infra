{ ... }:
{
  den.aspects.dev.shell.starship.homeManager =
    { lib, ... }:
    {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        settings = lib.importTOML ./catppuccin-powerline.toml;
      };
    };
}
