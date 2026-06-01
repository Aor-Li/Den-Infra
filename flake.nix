# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    den.url = "github:vic/den";
    devshell.url = "github:numtide/devshell";
    flake-file.url = "github:vic/flake-file";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
  };

}
