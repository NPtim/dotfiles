{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  msgpack,
  ruamel-yaml,
  toml,
  pyyaml,
  tomli,
  tomli-w,
}:

buildPythonPackage rec {
  pname = "python-box";
  version = "6.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bnwkOzVss24sDw5e14UJaf7eaqgSp/UB3ndomWx3RNc=";
  };

  build-system = [
    setuptools
    wheel
  ];

  optional-dependencies = {
    all = [
      msgpack
      ruamel-yaml
      toml
    ];
    msgpack = [
      msgpack
    ];
    pyyaml = [
      pyyaml
    ];
    ruamel-yaml = [
      ruamel-yaml
    ];
    toml = [
      toml
    ];
    tomli = [
      tomli
      tomli-w
    ];
    yaml = [
      ruamel-yaml
    ];
  };

  pythonImportsCheck = [
    "python_box"
  ];

  meta = {
    description = "Advanced Python dictionaries with dot notation access";
    homepage = "https://pypi.org/project/python-box/6.1.0/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
