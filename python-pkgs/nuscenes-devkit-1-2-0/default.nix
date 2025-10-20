{
  python3,
  fetchurl,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "nuscenes-devkit";
  version = "1.1.3";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/3a/13/e9124913743cd815fff25a3438072e4d184100e1d548ad926189e3e6988c/nuscenes_devkit-1.2.0-py3-none-any.whl";
    sha256 = "sha256-ds7g5/luyW1iae46y0/2norC+UE+l02etUIjPqdHm/E=";
  };
/*
  src = fetchFromGitHub rec {
    owner = "nutonomy";
    repo = "nuscenes-devkit";
    rev = "refs/tags/${version}";
    sha256 = "sha256-1EW/9KZskWI+BXhHs2aiX+OfiJY3aGrqyRweQ7gTLZU=";
  };

  sourceRoot = "source/setup";

  build-system = [
    setuptools
  ];
  */
}
