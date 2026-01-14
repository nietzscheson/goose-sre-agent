{
  description = "DevShell con Terraform, Docker, Python y ECR login";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        commonDeps = with pkgs; [
          awscli2
          goose-cli
        ];
      in {
        devShells.default = pkgs.mkShell {
          packages = commonDeps;

          shellHook = ''
            uv sync
            
            export GOOSE_PATH_ROOT="$PWD/.goose"
            mkdir -p "$GOOSE_PATH_ROOT"

            # AWS configuration (repo-local)
            export AWS_PROFILE=default
            export AWS_REGION=us-east-1
            export AWS_CONFIG_FILE="$PWD/.aws/config"

          '';
        };
      });

}
