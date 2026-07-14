{ ... }:
{
  den.aspects.system.fonts = {
    nixos =
      { lib, pkgs, ... }:
      {
        fonts.enableDefaultPackages = lib.mkDefault true;

        fonts.packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji

          nerd-fonts.monaspace
          nerd-fonts.caskaydia-cove
          maple-mono.NF-CN

          nerd-fonts.jetbrains-mono
          sarasa-gothic
        ];

        fonts.fontconfig = {
          enable = true;
          includeUserConf = true;

          # 具体选哪个字体做默认，属于审美偏好；未来若拆出 feature/appearance
          # （ricing）域，这部分 defaultFonts 可以搬过去，fonts.packages 留在这里。
          defaultFonts = {
            serif = lib.mkDefault [
              "Noto Serif CJK SC"
              "Noto Serif"
            ];
            sansSerif = lib.mkDefault [
              "Noto Sans CJK SC"
              "Noto Sans"
            ];
            monospace = lib.mkDefault [
              "Jetbrains Mono"
              "Sarasa Mono SC"
            ];
            emoji = lib.mkDefault [
              "Noto Color Emoji"
            ];
          };
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nerd-fonts.comic-shanns-mono
          lxgw-fusionkai
        ];
        fonts.fontconfig = {
          enable = true;
          defaultFonts = {
            monospace = [
              "Comic Shanns Mono NF"
              "fusionkai Mono NF"
            ];
          };
        };
      };
  };
}
