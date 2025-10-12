{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "nuscenes-devkit";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "nutonomy";
    repo = "nuscenes-devkit";
    rev = version;
    hash = "sha256-/OEKECh1Js+4IXxV/d1uC+h7bViMzql/AWWNltSHNNA=";
  };

  meta = {
    description = "The devkit of the nuScenes dataset";
    homepage = "https://github.com/nutonomy/nuscenes-devkit/tree/1.2.0";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "nuscenes-devkit";
    platforms = lib.platforms.all;
  };
}
