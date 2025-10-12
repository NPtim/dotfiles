{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  imageio,
  msgspec,
  nodeenv,
  numpy,
  opencv-python,
  psutil,
  requests,
  rich,
  scikit-image,
  scipy,
  tqdm,
  trimesh,
  tyro,
  websockets,
  yourdfpy,
  hypothesis,
  pre-commit,
  pyright,
  pytest,
  ruff,
  gdown,
  matplotlib,
  pandas,
  plotly,
  plyfile,
  pyliblzfse,
  robot-descriptions,
  torch,
}:

buildPythonPackage rec {
  pname = "viser";
  version = "1.0.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-g92BTbEeXKgYslj/cdUnxt31zbqIP7ooIwrsacUwvVE=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    imageio
    msgspec
    nodeenv
    numpy
    opencv-python
    psutil
    requests
    rich
    scikit-image
    scipy
    tqdm
    trimesh
    tyro
    websockets
    yourdfpy
  ];

  optional-dependencies = {
    dev = [
      hypothesis
      pre-commit
      pyright
      pytest
      ruff
    ];
    examples = [
      gdown
      matplotlib
      opencv-python
      pandas
      plotly
      plyfile
      pyliblzfse
      robot-descriptions
      torch
    ];
  };

  pythonImportsCheck = [
    "viser"
  ];

  meta = {
    description = "3D visualization + Python";
    homepage = "https://pypi.org/project/viser/1.0.0/";
    license = with lib.licenses; [ asl20 mit ];
    maintainers = with lib.maintainers; [ ];
  };
}
