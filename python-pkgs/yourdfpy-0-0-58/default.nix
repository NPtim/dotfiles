{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  setuptools-scm,
  wheel,
  importlib-metadata,
  lxml,
  numpy,
  six,
  trimesh,
  pyglet,
  pytest,
  pytest-cov,
}:

buildPythonPackage rec {
  pname = "yourdfpy";
  version = "0.0.58";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-aNI2iIAsjiOEOomB+Ci8ypp4dc2wK+fzoOZ7QpKXJ/M=";
  };

  build-system = [
    setuptools
    setuptools-scm
    wheel
  ];

  dependencies = [
    importlib-metadata
    lxml
    numpy
    six
    trimesh
  ];

  optional-dependencies = {
    full = [
      pyglet
    ];
    testing = [
      pytest
      pytest-cov
      setuptools
    ];
  };

  pythonImportsCheck = [
    "yourdfpy"
  ];

  meta = {
    description = "A simpler and easier-to-use library for loading, manipulating, saving, and visualizing URDF files";
    homepage = "https://pypi.org/project/yourdfpy/0.0.58/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
