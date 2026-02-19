{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  python3,
  patchelfUnstable,
  autoPatchelfHook,
  git,
  qhull,
  pybind11
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

  buildInputs = [
    qhull
    pybind11
  ];

  nativeBuildInputs = [
    cmake
    python3
    patchelfUnstable
    autoPatchelfHook
    git
  ];

  cmakeFlags = [ 
    "-DBUILD_ISPC_MODULE=OFF" 
    "-DUSE_SYSTEM_QHULLCPP=ON"
    "-Dpybind11_DIR=${python3.pkgs.pybind11}/${python3.sitePackages}/pybind11/share/cmake/pybind11"
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
