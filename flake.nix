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

        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          pip
        ]);

        commonDeps = with pkgs; [
          pythonEnv
          uv
          git
          terraform
          python312
          awscli2
          httpie
          go
          go-task
          docker
          jq
          nodejs_20
          nodePackages.lerna
          subfinder
          amass
          yarn
          goose-cli
        ];
      in {
        devShells.default = pkgs.mkShell {
          packages = commonDeps;

          shellHook = ''
            pyenv global system
            export pythonEnv=${pythonEnv}
            export PATH=$PATH:${pythonEnv}/bin

            export GOOSE_PATH_ROOT="$PWD/.goose"
            mkdir -p "$GOOSE_PATH_ROOT"

            # AWS configuration (repo-local)
            export AWS_PROFILE=default
            export AWS_REGION=us-east-1
            export AWS_CONFIG_FILE="$PWD/.aws/config"

            mkdir -p ~/.docker
          '';
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib

          ];

        };
      });

}
