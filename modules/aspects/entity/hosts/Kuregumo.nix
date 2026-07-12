{ den, ... }:
{
  den.aspects.Kuregumo = {
    nixos = {
      # FIXME: 临时使用的占位配置，在虚拟机中生成 hardware-configuration 后重写
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
      };
    };
  };
}
