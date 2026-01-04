{
  description = "Flake package for movier";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    utils,
    nixpkgs,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      py3pkgs = pkgs.python3Packages;
      chardet = py3pkgs.chardet;

      packages.default = packages.movier;
      packages.movier = py3pkgs.buildPythonApplication {
        name = "movier";
        version = "0.4.0";
        src = ./.;

        propagatedBuildInputs = [
          chardet
        ];

        pyproject = true;
        build-system = [py3pkgs.setuptools];
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
