{
  description = "Flake package for movier";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    utils,
    nixpkgs,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      chardet = pkgs.python3Packages.chardet;

      packages.default = packages.movier;
      packages.movier = pkgs.python3Packages.buildPythonApplication {
        name = "movier";
        version = "0.4.0";
        src = ./.;

        propagatedBuildInputs = [
          chardet
        ];
      };

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          (python3.withPackages (_: [chardet]))
        ];
      };
    in {
      inherit packages devShells;
    });
}
