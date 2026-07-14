{ ... }:
let
  common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vim
        wget
        tree
        htop
        btop
        fd
        fzf
      ];

      environment.variables.EDITOR = "nvim";
    };
in
{
  den.aspects.system.tools = {
    nixos = common;
    darwin = common;
  };
}
