{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager = {
     url = "github:nix-community/home-manager?ref=release-25.05";
     inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pythonEnv = pkgs.python3.withPackages (ps: with ps; [
        pip setuptools wheel ninja
      ]);
      cuda = pkgs.cudaPackages_11.cudatoolkit; # für nerfstudio
    in
      {
      tims-neovim = (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./nvf/configuration.nix ];
      }).neovim;

      # gaussian splatting dev shell
      devShells.${system}.default = pkgs.mkShell {
        name = "nerfstudio-shell-for-gs";

        packages = [
          pkgs.xorg.libX11 pkgs.xorg.libXext pkgs.xorg.libXi pkgs.xorg.libXrandr pkgs.xorg.libXfixes
          pkgs.xorg.libXcursor pkgs.xorg.libXinerama
          pkgs.libGL pkgs.libGLU pkgs.glew
          pkgs.ffmpeg

          pythonEnv
          pkgs.cmake
          pkgs.pkg-config
          # pkgs.gcc11
          cuda
          pkgs.systemd
          pkgs.colmap
        ];

        shellHook = ''
          export CUDA_HOME=${cuda}
          export CUDACXX=${cuda}/bin/nvcc
          export QT_QPA_PLATFORM=xcb

          NEW_LD="/run/opengl-driver/lib:/run/opengl-driver-32/lib:${pkgs.lib.makeLibraryPath [
            pkgs.xorg.libX11 pkgs.xorg.libXext pkgs.xorg.libXi pkgs.xorg.libXrandr pkgs.xorg.libXfixes
            pkgs.xorg.libXcursor pkgs.xorg.libXinerama pkgs.xorg.libXrender pkgs.xorg.libxcb pkgs.xorg.libXau pkgs.xorg.libXdmcp
            pkgs.libGL pkgs.libGLU pkgs.glew pkgs.systemd pkgs.gcc14.cc.lib
          ]}"

          if [ -n "$LD_LIBRARY_PATH" ]; then
            export LD_LIBRARY_PATH="$NEW_LD:$LD_LIBRARY_PATH"
          else
            export LD_LIBRARY_PATH="$NEW_LD"
          fi

          export __GLX_VENDOR_LIBRARY_NAME=nvidia
        '';
      };

      nixosConfigurations = {
        tims-nixos-machine = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = { inherit inputs; };

          modules = [
            ./nixos/configuration.nix
            ./home
            inputs.home-manager.nixosModules.home-manager
            ({pkgs, ...}: {
              environment.systemPackages = [self.tims-neovim];
            })
          ];
        };
      };
    };
}
