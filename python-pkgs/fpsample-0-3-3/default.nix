{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  cargo,
  patchelf,
  rustPlatform,
  rustc,
  numpy,
}:

buildPythonPackage rec {
  pname = "fpsample";
  version = "0.3.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "leonardodalinky";
    repo = "fpsample";
    rev = "v${version}";
    hash = "sha256-72XdPis+J3Lb1aa0/AicBqxPtOJb/ZXOsGjMuA/leNI=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };

  build-system = [
    cargo
    patchelf
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    rustc
  ];

  dependencies = [
    numpy
  ];

  pythonImportsCheck = [
    "fpsample"
  ];

  meta = {
    description = "Python efficient farthest point sampling (FPS) library. Compatible with numpy";
    homepage = "https://github.com/leonardodalinky/fpsample/tree/v0.3.3";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
