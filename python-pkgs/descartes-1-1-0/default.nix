{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  matplotlib,
}:

buildPythonPackage rec {
  pname = "descartes";
  version = "1.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-E1pQIUavXtb/NZl14uvF+ktxtUMsNVwsr9xt6hM3A1s=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    matplotlib
  ];

  pythonImportsCheck = [
    "descartes"
  ];

  meta = {
    description = "Use geometric objects as matplotlib paths and patches";
    homepage = "https://pypi.org/project/descartes/1.1.0/";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ ];
  };
}
