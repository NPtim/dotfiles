{
  python3,
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  jaxtyping,
  ninja,
  numpy,
  rich,
  torch,
  typing-extensions,
  black,
  build,
  isort,
  pylint,
  pytest,
  pytest-xdist,
  pyyaml,
  twine,
  typeguard,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "gsplat";
  version = "1.4.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-iqgaeF4Nrz7WDQuZMKVsDzNygOaYk1HR8bdOIc8ZAWA=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    jaxtyping
    ninja
    numpy
    rich
    torch
    typing-extensions
  ];

  optional-dependencies = {
    dev = [
      black
      build
      isort
      pylint
      pytest
      pytest-xdist
      pyyaml
      twine
      typeguard
    ];
  };

  pythonImportsCheck = [
    "gsplat"
  ];

  meta = {
    description = "Python package for differentiable rasterization of gaussians";
    homepage = "https://pypi.org/project/gsplat/1.4.0/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
