{ lib, ... }:
{
  den.schema.user = {
    # use stand-alone home-manager
    classes = lib.mkDefault [ ];
  };
}
