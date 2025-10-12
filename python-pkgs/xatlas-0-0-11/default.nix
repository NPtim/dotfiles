{
  lib,
  buildPythonPackage,
  fetchPypi,
  scikit-build-core,
  numpy,
  pytest,
  scipy,
  trimesh,
  cmake,
  ninja
}:

buildPythonPackage rec {
  pname = "xatlas";
  version = "0.0.11";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-cvC8bELBklK+h+lH2d/iUcjWxpQ/1D49Fz3caxr61pM=";
  };

  nativeBuildInputs = [
    cmake
    ninja
  ];

  build-system = [
    scikit-build-core
  ];

  dontUseCmakeConfigure = true;
  dontUseCmakeBuild = true;
  dontUseCmakeInstall = true;

  optional-dependencies = {
    test = [
      numpy
      pytest
      scipy
      trimesh
    ];
  };

  pythonImportsCheck = [
    "xatlas"
  ];

  meta = {
    description = "Python bindings for xatlas";
    homepage = "https://pypi.org/project/xatlas/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
