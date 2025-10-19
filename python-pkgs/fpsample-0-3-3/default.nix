{
  python3,
  fetchFromGitHub,
  maturin
}:

python3.pkgs.buildPythonPackage rec {
  pname = "fpsample";
  version = "0.3.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "leonardodalinky";
    repo = "fpsample";
    rev = "v${version}";
    sha256 = "72XdPis+J3Lb1aa0/AicBqxPtOJb/ZXOsGjMuA/leNI=";
  };

  build-system = [
    maturin
  ];
}
