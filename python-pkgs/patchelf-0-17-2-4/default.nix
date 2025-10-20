{
  lib,
  buildPythonPackage,
  fetchPypi,
  scikit-build-core,
  importlib-metadata,
  pytest,
}:

buildPythonPackage rec {
  pname = "patchelf";
  version = "0.17.2.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-lw7lzYrzPl6iCZUQsvkBP6G41c12O/P9OWEoHBgQGgk=";
  };

  build-system = [
    scikit-build-core
  ];

  optional-dependencies = {
    test = [
      importlib-metadata
      pytest
    ];
  };

  pythonImportsCheck = [
    "patchelf"
  ];

  meta = {
    description = "A small utility to modify the dynamic linker and RPATH of ELF executables";
    homepage = "https://pypi.org/project/patchelf/0.17.2.4/";
    license = with lib.licenses; [ asl20 gpl3Only ];
    maintainers = with lib.maintainers; [ ];
  };
}
