{
  python3,
  fetchPypi
}:

python3.pkgs.buildPythonPackage rec {
  pname = "open3d";
  version = "0.19.0";
  format = "wheel";

  src = fetchPypi rec {
    inherit pname version format;
    sha256 = "";
    dist = python;
    python = "py3";
  };
  /*
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/b7/52/1814945a5dfbb34c8c18c23f314b07e09be6f15db8adcf0a35d98edc1f43/open3d-0.19.0-cp38-cp38-manylinux_2_31_x86_64.whl";
    sha256 = "0lvlg8wcx7qgbhb8jkdfl3ib4jwwi9m64ks0a6w6gszkn7v44p9h";
  };

  propagatedBuildInputs = with pkgs; [
    xorg.libX11 # libX11.so.6
    systemd # libudev.so.1
    stdenv.cc.cc.lib # libgomp.so.1
    libGL # libGL.so.1
    libcxx # libc++abi.so.1
  ];

  pythonImportsCheck = [
    "open3d"
  ];

  LD_LIBRARY_PATH = "${lib.makeLibraryPath propagatedBuildInputs}";

  meta = {
    description = "Open3D: A Modern Library for 3D Data Processing.";
    homepage = "https://wwww.open3d.org";
    license = lib.licenses.mit;
  };
  */
}
