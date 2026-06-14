{ lib, den, ... }:
{
  den.schema.host = {
    options = { 
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
          "other"
        ];
        default = "nixos";
        description = "The Linux distribution running on the host device.";
      };
    };

    includes = [ den.aspects.system ];
  };
}
