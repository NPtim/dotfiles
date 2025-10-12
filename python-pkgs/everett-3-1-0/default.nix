{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  build,
  cogapp,
  mypy,
  pytest,
  ruff,
  sphinx,
  sphinx-rtd-theme,
  tox,
  tox-gh-actions,
  tox-uv,
  twine,
  types-pyyaml,
  configobj,
  pyyaml,
}:

buildPythonPackage rec {
  pname = "everett";
  version = "3.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-RhddpbywbBk6oSnllxS8qYE0T/Bnw6i8LmJbwLPcAfY=";
  };

  build-system = [
    setuptools
    wheel
  ];

  optional-dependencies = {
    dev = [
      build
      cogapp
      mypy
      pytest
      ruff
      sphinx
      sphinx-rtd-theme
      tox
      tox-gh-actions
      tox-uv
      twine
      types-pyyaml
    ];
    ini = [
      configobj
    ];
    sphinx = [
      sphinx
    ];
    yaml = [
      pyyaml
    ];
  };

  pythonImportsCheck = [
    "everett"
  ];

  meta = {
    description = "Configuration library for Python applications";
    homepage = "https://pypi.org/project/everett/3.1.0/";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ ];
  };
}
