{ den, ... }:
{
  den.aspects.dev.editors.neovim = {

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
