{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  numpy,
}:

buildPythonPackage rec {
  pname = "splines";
  version = "0.3.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-x9L6jCF6RodTMH1Im9H7pZUyx3rsB+8eDKqD0fN48G0=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    numpy
  ];

  pythonImportsCheck = [
    "splines"
  ];

  meta = {
    description = "Splines in Euclidean Space and Beyond";
    homepage = "https://pypi.org/project/splines/0.3.0/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
