{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  python3
}:

stdenv.mkDerivation rec {
  pname = "open3-d";
  version = "0.19.0";

  src = fetchFromGitHub {
    owner = "isl-org";
    repo = "Open3D";
    rev = "v${version}";
    hash = "sha256-jWjtfDcjDBOQHH4s2e1P8ye19JlucYIZPi0pgvOsdcA=";
  };

  nativeBuildInputs = [
    cmake
    python3
  ];

  meta = {
    description = "Open3D: A Modern Library for 3D Data Processing";
    homepage = "https://github.com/isl-org/Open3D/tree/v0.19.0";
    changelog = "https://github.com/isl-org/Open3D/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "open3-d";
    platforms = lib.platforms.all;
  };
}
