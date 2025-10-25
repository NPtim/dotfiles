{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  scikit-build,
  setuptools,
  setuptools-scm,
  wheel,
  cmake,
  ninja,
  autoconf,
  automake,
  libtool,
  gettext,
  help2man,
}:

buildPythonPackage rec {
  pname = "patchelf-pypi";
  version = "0.18.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mayeut";
    repo = "patchelf-pypi";
    rev = "v${version}";
    hash = "sha256-Zcx46OfQiZHmCi7byrhgwGPl5eINB4mJw2tFcpgNFrY=";
    fetchSubmodules = true;
  };

  build-system = [
    scikit-build
    setuptools
    setuptools-scm
    wheel
  ];

  nativeBuildInputs = [
    cmake
    ninja
    autoconf
    automake
    libtool
    gettext
    help2man
  ];

  dontUseCmakeConfigure = true;
  dontUseCmakeBuild = true;
  dontUseCmakeInstall = true;

  pythonImportsCheck = [
    "patchelf_pypi"
  ];

  meta = {
    description = "Pip install patchelf. patchelf Python wheel for PyPI";
    homepage = "https://github.com/mayeut/patchelf-pypi/tree/v0.18.0.0";
    license = with lib.licenses; [ gpl3Only asl20 ];
    maintainers = with lib.maintainers; [ ];
  };
}
