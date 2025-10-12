{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  ipywidgets,
  pygments,
  jupyter-packaging,
  jupyterlab,
}:

buildPythonPackage rec {
  pname = "open3d";
  version = "0.19.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jWjtfDcjDBOQHH4s2e1P8ye19JlucYIZPi0pgvOsdcA=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    ipywidgets
    pygments
    jupyter-packaging
    jupyterlab
    setuptools
    wheel
  ];

  pythonImportsCheck = [
    "open3d"
  ];

  meta = {
    description = "Open3D: A Modern Library for 3D Data Processing.";
    homepage = "https://pypi.org/project/open3d/0.19.0/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
