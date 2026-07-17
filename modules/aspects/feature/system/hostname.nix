{ ... }:
{
  # host name is setted by den.provides.hostname
  # 这里只补 darwin 特有的展示名。
  den.aspects.system.hostname =
    { host, ... }:
    {
      darwin.networking = {
        computerName = host.hostName;
        localHostName = host.hostName;
      };
    };
}
