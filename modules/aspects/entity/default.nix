{ den, lib, ... }:
{
  # general defaults
  den.default = {
    nixos.system.stateVersion = lib.mkDefault "25.11";
    homeManager.home.stateVersion = lib.mkDefault "25.11";
    darwin.system.stateVersion = lib.mkDefault 6;

    includes = [
      den.aspects.nix
      den.provides.define-user
      den.provides.hostname
    ];
  };

  # host defaults
  den.schema.host.includes = [
    den.aspects.system 
  ];

  # home defaults
  den.schema.home.includes = [];
}
