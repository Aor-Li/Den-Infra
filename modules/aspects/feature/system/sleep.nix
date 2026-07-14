{ lib, ... }:
{
  den.schema.host =
    { config, lib, ... }:
    {
      options.sleep = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether this host is allowed to sleep/suspend/hibernate.";
      };

      config.sleep = lib.mkDefault (config.role != "server");
    };

  den.aspects.system.sleep =
    { host, ... }:
    {
      nixos = lib.mkIf (!host.sleep) {
        systemd.targets = {
          sleep.enable = false;
          suspend.enable = false;
          hibernate.enable = false;
          hybrid-sleep.enable = false;
        };

        services.logind.settings.Login = {
          HandleLidSwitch = "ignore";
          HandleLidSwitchExternalPower = "ignore";
          HandlePowerKey = "ignore";
          HandleSuspendKey = "ignore";
          HandleHibernateKey = "ignore";
        };
      };
    };
}
