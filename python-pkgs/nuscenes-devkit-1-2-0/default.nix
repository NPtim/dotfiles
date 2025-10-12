{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  cachetools,
  descartes,
  fire,
  matplotlib,
  numpy,
  opencv-python-headless,
  pillow,
  pyquaternion,
  scikit-learn,
  scipy,
  shapely,
  tqdm,
  parameterized,
  pycocotools,
}:

buildPythonPackage rec {
  pname = "nuscenes-devkit";
  version = "1.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-/OEKECh1Js+4IXxV/d1uC+h7bViMzql/AWWNltSHNNA=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    cachetools
    descartes
    fire
    matplotlib
    numpy
    opencv-python-headless
    pillow
    pyquaternion
    scikit-learn
    scipy
    shapely
    tqdm
    parameterized
    pycocotools
  ];

  pythonImportsCheck = [
    "nuscenes-devkit"
  ];

  meta = {
    description = "The official devkit of the nuScenes dataset (www.nuscenes.org).";
    homepage = "https://pypi.org/project/nuscenes-devkit/1.2.0/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
