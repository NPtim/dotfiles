{
  python3,
  autoPatchelfHook,
  stdenv
}:

python3.pkgs.buildPythonPackage rec {
  pname = "open3d";
  version = "0.18.0";  # letzte Version mit Wheel für dein Python
  format = "wheel";

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    format = "wheel";
    dist = "cp313";
    python = "cp313";
    abi = "cp313";
    platform = "manylinux_2_27_x86_64.manylinux2014_x86_64";  # prüfe genau
    hash = "sha256-...";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  pythonImportsCheck = [ "open3d" ];
}
