{
  lib,
  buildPythonPackage,
  fetchurl,
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
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/3a/13/e9124913743cd815fff25a3438072e4d184100e1d548ad926189e3e6988c/nuscenes_devkit-1.2.0-py3-none-any.whl";
    sha256 = "1wcv8ykkw8s2nng4v5ry87ww52lyyr7wnfpfd5i6vjbfz7ky1kkn";
  };

  propagatedBuildInputs = [
    cachetools descartes fire matplotlib numpy
    opencv-python-headless pillow pyquaternion
    scikit-learn scipy shapely tqdm parameterized pycocotools
  ];

  build-system = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [
    "nuscenes"
  ];

  meta = {
    description = "The official devkit of the nuScenes dataset (www.nuscenes.org).";
    homepage = "https://pypi.org/project/nuscenes-devkit/1.2.0/";
    license = lib.licenses.asl20;
  };
}
