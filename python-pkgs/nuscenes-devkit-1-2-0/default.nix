{
  fetchPypi,
  python3
}:

python3.pkgs.buildPythonPackage rec {
  pname = "nuscenes-devkit";
  version = "1.2.0";
  format = "wheel";

  src = fetchPypi rec {
    inherit pname version format;
    sha256 = "";
    dist = python;
    python = "py3";
  };
}
