{ lib, ... }:
{
  den.schema.host =
    { config, ... }:
    {
      options = {
        # 该主机是否运行图形环境（desktop 域的总开关）。
        # 默认由 role/distro/env 推导：非 server、且为 nixos、且不在 wsl 里。
        # 个别主机可在 profile.nix 中显式覆盖。
        graphical = lib.mkOption {
          type = lib.types.bool;
          default = config.role != "server" && config.distro == "nixos" && config.env != "wsl";
          defaultText = lib.literalExpression ''role != "server" && distro == "nixos" && env != "wsl"'';
          description = "Whether this host runs a graphical desktop environment.";
        };

        env = lib.mkOption {
          type = lib.types.enum [
            "physical"
            "virtual"
            "wsl"
          ];
          default = "physical";
          description = "The environment in which the host device is running.";
        };

        role = lib.mkOption {
          type = lib.types.enum [
            "desktop"
            "laptop"
            "server"
          ];
          default = "desktop";
          description = "The role of the host device.";
        };

        distro = lib.mkOption {
          type = lib.types.enum [
            "nixos"
            "darwin"
          ];
          default = "nixos";
          description = "The Linux distribution running on the host device.";
        };
      };
    };
}
