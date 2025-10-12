{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  rich,
  torch,
  typing-extensions,
  black,
  build,
  isort,
  ninja,
  pylint,
  pytest,
  pytest-xdist,
  pyyaml,
  twine,
  typeguard,
}:

buildPythonPackage rec {
  pname = "nerfacc";
  version = "0.5.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-kEl3g7G4Rt62x/BwRSDqezSCo2PzouI+M7326LzmvaU=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    rich
    torch
    typing-extensions
  ];

  optional-dependencies = {
    dev = [
      black
      build
      isort
      ninja
      pylint
      pytest
      pytest-xdist
      pyyaml
      twine
      typeguard
    ];
  };

  pythonImportsCheck = [
    "nerfacc"
  ];

  meta = {
    description = "A General NeRF Acceleration Toolbox";
    homepage = "https://pypi.org/project/nerfacc/0.5.2/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
