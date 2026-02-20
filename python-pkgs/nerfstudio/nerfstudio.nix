{
  python3,
  fetchurl,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "nerfstudio";
  version = "1.1.5";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/ee/86/93a22f779f3810be8ddbaae9073c7adfed97d4703a2953e66d36bdb4037a/nerfstudio-1.1.5-py3-none-any.whl";
    sha256 = "sha256-ee6d3d360a1e363ad2f1703b602da5a8987485bff812d0ae8aa4a6e672b994c4";
  };
}
