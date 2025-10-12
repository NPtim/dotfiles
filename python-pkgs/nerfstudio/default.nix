{
  lib,
  python3,
  fetchFromGitHub,
  comet-ml,
  fpsample,
  gsplat,
  nerfacc
}:

python3.pkgs.buildPythonApplication rec {
  pname = "nerfstudio";
  version = "1.1.5";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "nerfstudio-project";
    repo = "nerfstudio";
    rev = "v${version}";
    hash = "sha256-UmjvNv0yrOrTvVk1r5GEq9Kjnj+hMIK7ag16N8w7F8o=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  dependencies = with python3.pkgs; [
    appdirs
    av
    comet-ml
    cryptography
    fpsample
    gdown
    gsplat
    h5py
    imageio
    importlib-metadata
    ipywidgets
    jaxtyping
    jupyterlab
    matplotlib
    mediapy
    msgpack
    msgpack-numpy
    nerfacc
    newrawpy
    ninja
    nuscenes-devkit
    open3d
    opencv-python-headless
    packaging
    pathos
    pillow
    plotly
    protobuf
    pymeshlab
    pyngrok
    pyquaternion
    python-socketio
    pytorch-msssim
    rawpy
    requests
    rich
    scikit-image
    splines
    tensorboard
    tensorly
    timm
    torch
    torchmetrics
    torchvision
    trimesh
    typing-extensions
    tyro
    viser
    wandb
    xatlas
  ];

  optional-dependencies = with python3.pkgs; {
    dev = [
      awscli
      diffusers
      opencv-stubs
      pre-commit
      projectaria-tools
      pycolmap
      pyright
      pytest
      pytest-xdist
      ruff
      sshconf
      torch
      transformers
      typeguard
    ];
    docs = [
      furo
      ipython
      myst-nb
      nbconvert
      nbformat
      readthedocs-sphinx-search
      sphinx
      sphinx-argparse
      sphinx-copybutton
      sphinx-design
      sphinxemoji
      sphinxext-opengraph
    ];
    gen = [
      accelerate
      bitsandbytes
      diffusers
      sentencepiece
      transformers
    ];
  };

  pythonImportsCheck = [
    "nerfstudio"
  ];

  meta = {
    description = "A collaboration friendly studio for NeRFs";
    homepage = "https://github.com/nerfstudio-project/nerfstudio/tree/main";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "nerfstudio";
  };
}
