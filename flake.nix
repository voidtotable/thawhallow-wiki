{
  description = "Thawhallow Wiki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        commonArgs = {
          inherit src;

          # uncomment if the project is a workspace
          # pname = "{{ project_name }}";
          # version = "0.1.0";
        };

      in
      rec {

        # uncomment if there is a binary to be run
        # apps.{{ project_name }} = flake-utils.lib.mkApp {
        #   drv = packages.{{ project_name }};
        #   name = "{{ project_name }}";
        # };
        # apps.default = apps.{{ project_name }};

        devShells.default = pkgs.mkShell {
          inputsFrom = builtins.attrValues self.checks.${system};

          packages = with pkgs; [
            mdbook

            # Orchestration
            just

            # GitHub tooling
            gh

            # Nix tooling
            nixfmt-rfc-style
          ];
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        };
      });
}