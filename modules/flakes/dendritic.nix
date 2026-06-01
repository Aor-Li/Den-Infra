{ inputs, ... }:
{
  flake-file.inputs = {
    den.url = "github:vic/den";
    import-tree.url = "github:denful/import-tree";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
}
