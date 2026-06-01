{ inputs, ... }:
{
  flake-file.inputs = {
    den.url = "github:vic/den";
  };

  imports = [
    inputs.den.flakeModule or { }
  ];
}
