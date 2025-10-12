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
      py = pkgs.python3Packages;
      #pythonEnv = pkgs.python3.withPackages (ps: with ps; [
      #pip setuptools wheel ninja
      #]);
      cuda = pkgs.cudaPackages_11.cudatoolkit; # für nerfstudio

      xatlas-0-0-11-python-package = pkgs.callPackage ./python-pkgs/xatlas-0-0-11/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage scikit-build-core numpy pytest scipy trimesh;
      };

      yourdfpy-0-0-58-python-package = pkgs.callPackage ./python-pkgs/yourdfpy-0-0-58/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage setuptools setuptools-scm wheel importlib-metadata
        lxml numpy six trimesh pyglet pytest pytest-cov;
      };

      viser-1-0-0-python-package = pkgs.callPackage ./python-pkgs/viser-1-0-0/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage hatchling imageio msgspec nodeenv numpy opencv-python
        psutil requests rich scikit-image scipy tqdm trimesh tyro websockets
        hypothesis pre-commit pyright pytest ruff gdown matplotlib
        pandas plotly plyfile pyliblzfse robot-descriptions torch;
        yourdfpy = yourdfpy-0-0-58-python-package;
      };

      splines-0-3-0-python-package = pkgs.callPackage ./python-pkgs/splines-0-3-0/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py) buildPythonPackage setuptools wheel numpy;
      };

      open3d-0-19-0-python-package = pkgs.callPackage ./python-pkgs/open3d-0-19-0/default.nix {
        inherit (pkgs) lib stdenv fetchFromGitHub cmake;
      };

      nuscenes-devkit-1-2-0-python-package = pkgs.callPackage ./python-pkgs/nuscenes-devkit-1-2-0/default.nix {
        inherit (pkgs) lib stdenv fetchFromGitHub;
      };

      nerfacc-0-5-2-python-package = pkgs.callPackage ./python-pkgs/nerfacc-0-5-2/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage setuptools wheel rich torch typing-extensions black
        build isort ninja pylint pytest pytest-xdist pyyaml twine typeguard;
      };
      
      gsplat-1-4-0-python-package = pkgs.callPackage ./python-pkgs/gsplat-1-4-0/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage setuptools wheel jaxtyping ninja numpy rich torch
        typing-extensions black build isort pylint pytest pytest-xdist pyyaml
        twine typeguard;
      };

      fpsample-0-3-3-python-package = pkgs.callPackage ./python-pkgs/fpsample-0-3-3/default.nix {
        inherit (pkgs) lib fetchFromGitHub cargo patchelf rustPlatform rustc;
        inherit (py)
        buildPythonPackage numpy;
      };

      everett-3-1-0-python-package = pkgs.callPackage ./python-pkgs/everett-3-1-0/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage setuptools wheel build cogapp mypy pytest ruff sphinx
        sphinx-rtd-theme tox tox-gh-actions tox-uv twine types-pyyaml configobj
        pyyaml;
      };

      comet-ml-3-53-1-python-package = pkgs.callPackage ./python-pkgs/comet-ml-3-53-1/default.nix {
        inherit (pkgs) lib fetchPypi;
        inherit (py)
        buildPythonPackage setuptools wheel dulwich; everett = everett-3-1-0-python-package; 
        inherit (py)
        importlib-metadata
        jsonschema psutil python-box requests requests-toolbelt rich
        semantic-version sentry-sdk simplejson urllib3 wrapt wurlitzer;
      };
      nerfstudio-python-package = import ./python-pkgs/nerfstudio/default.nix {
        inherit (pkgs) lib  fetchFromGitHub python3; 
        comet-ml = comet-ml-3-53-1-python-package; 
        fpsample = fpsample-0-3-3-python-package;
        gsplat = gsplat-1-4-0-python-package;
        nerfacc = nerfacc-0-5-2-python-package;
        nuscenes-devkit = nuscenes-devkit-1-2-0-python-package;
        open3d = open3d-0-19-0-python-package;
        splines = splines-0-3-0-python-package;
        viser = viser-1-0-0-python-package;
        xatlas = xatlas-0-0-11-python-package;
      };
    in
      {
      tims-neovim = (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./nvf/configuration.nix ];
      }).neovim;

      # gaussian splatting dev shell
      devShells.${system} = {
        nerfstudio = pkgs.mkShell {
          packages = [
            pkgs.python3
            nerfstudio-python-package
          ];

          shellHook = '' echo "Entered devshell for nerfstudio"'';
        };

        pip = pkgs.mkShell {
          packages = with pkgs; [
            (python311.withPackages (p: with p; [
              pip wheel
            ]))
          ];
        };

        first-try = pkgs.mkShell {
          name = "nerfstudio-shell-for-gs";

          packages = with pkgs; [
            # Grafik + GL
            xorg.libX11 xorg.libXext xorg.libXi xorg.libXrandr xorg.libXfixes
            xorg.libXcursor xorg.libXinerama xorg.libXrender xorg.libxcb xorg.libXau xorg.libXdmcp
            libGL libGLU glew

            # Tools
            ffmpeg cmake pkg-config colmap glxinfo

            # Python Bootstrap
            (python311.withPackages (ps: with ps; [ pip setuptools wheel ninja opencv4 /*pycolmap*/ ]))

            # CUDA Toolkit ist optional für Kompilate – PyTorch-Wheels bringen i.d.R. CUDA-Runtime mit.
            cudaPackages.cudatoolkit

            # **Wichtig für Pip-Wheels zur Laufzeit**:
            zlib zstd bzip2 libffi openssl
            stdenv.cc.cc.lib  # libstdc++.so.6, libgcc_s.so.1
            systemd

            # für cv2, damit er libgthread-2.0.so.0 findet
          ];

          shellHook = ''
            # Wayland -> XCB, sonst Qt/GL Ärger
            export QT_QPA_PLATFORM=wayland

            # Sorge dafür, dass NVIDIA-GL wirklich benutzt wird:
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export LIBGL_DRIVERS_PATH=/run/opengl-driver/lib/dri

            # Triton braucht die libcuda.so
            export TRITON_LIBCUDA_PATH=/run/opengl-driver/lib

            # für bessere TF32-Performance
            export TORCH_ALLOW_TF32=1

            # Tuning für das eigentliche training
            export TORCH_FLOAT32_MATMUL_PRECISION=high
            export PYTORCH_CUDA_ALLOC_CONF="expandable_segments:True,max_split_size_mb:64,garbage_collection_threshold:0.9"


            # Runtime-Libs für Pip-Wheels (NumPy, OpenCV, PyTorch, …)
            EXTRA_LIBS="${pkgs.lib.makeLibraryPath [
                pkgs.zlib pkgs.zstd pkgs.bzip2 pkgs.libffi pkgs.openssl
                pkgs.xorg.libX11 pkgs.xorg.libXext pkgs.xorg.libXi pkgs.xorg.libXrandr pkgs.xorg.libXfixes
                pkgs.xorg.libXcursor pkgs.xorg.libXinerama pkgs.xorg.libXrender pkgs.xorg.libxcb pkgs.xorg.libXau pkgs.xorg.libXdmcp
                pkgs.libGL pkgs.libGLU pkgs.glew
                pkgs.stdenv.cc.cc.lib
                pkgs.systemd
                pkgs.glib
              ]}"
            RENDERER_LIBS="/run/opengl-driver/lib:/run/opengl-driver-32/lib"

            if [ -n "$LD_LIBRARY_PATH" ]; then
              export LD_LIBRARY_PATH="$EXTRA_LIBS:$RENDERER_LIBS:$LD_LIBRARY_PATH"
            else
              export LD_LIBRARY_PATH="$EXTRA_LIBS:$RENDERER_LIBS"
            fi

            echo "[nerfstudio-gpu-shell] LD_LIBRARY_PATH prepared."
            echo "[nerfstudio-gpu-shell] OpenGL renderer should be NVIDIA. Test mit: glxinfo | grep 'OpenGL renderer'"
          '';
        };
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
