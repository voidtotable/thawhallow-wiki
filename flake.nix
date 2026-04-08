{
  description = "Thawhallow Wiki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

      in {

        # uncomment if there is a binary to be run
        # apps.{{ project_name }} = flake-utils.lib.mkApp {
        #   drv = packages.{{ project_name }};
        #   name = "{{ project_name }}";
        # };
        # apps.default = apps.{{ project_name }};

        devShells.default = pkgs.mkShell {

          packages = with pkgs; [
            mdbook
            just
            gh
            nixfmt-rfc-style
          ];
          
        };
      });
}
