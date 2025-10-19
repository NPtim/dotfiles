{
  buildPythonPackage,
  fetchPypi,
  python3
}:

python3.pkgs.buildPythonPackage rec {
  pname = "fpsample";
  version = "0.3.3";
  format = "wheel";

  src = fetchPypi rec {
    inherit pname version format;
    sha256 = "";
    dist = python;
    python = "py3";
  };
}
