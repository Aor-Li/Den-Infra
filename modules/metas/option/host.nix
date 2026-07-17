{ lib, ... }:
{
  den.schema.host =
    { config, ... }:
    {
      options = {
        #############################
        ### Major Manual Triggers ###
        #############################
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

        ##########################
        ### Auxiliary Funtions ###
        ########################## 
        graphical = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether this host runs a graphical desktop environment within nix configurations.";
        };
      };
    };
}
