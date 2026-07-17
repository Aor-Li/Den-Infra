{ den, ... }:
{
  den.aspects.dev =
    { ... }:
    {
      includes = [
        den.aspects.dev.shell
        den.aspects.dev.git
        den.aspects.dev.env
        den.aspects.dev.editors
        den.aspects.dev.langs
        den.aspects.dev.tools
      ];
    };
}
