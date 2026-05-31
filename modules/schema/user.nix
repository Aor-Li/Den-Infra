# this config applies to all user
{ lib, ... }:
{
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
