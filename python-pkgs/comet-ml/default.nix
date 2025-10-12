{
  lib,
  python3,
  fetchPypi,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "comet-ml";
  version = "3.53.1";
  pyproject = true;

  src = fetchPypi {
    pname = "comet_ml";
    inherit version;
    hash = "sha256-r3abmDqYzJOtdYswe4jK6xkVqGNtzUgSIAMtCLW5rBI=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  dependencies = with python3.pkgs; [
    dulwich
    everett
    importlib-metadata
    jsonschema
    psutil
    python-box
    requests
    requests-toolbelt
    rich
    semantic-version
    sentry-sdk
    setuptools
    simplejson
    urllib3
    wrapt
    wurlitzer
  ];

  pythonImportsCheck = [
    "comet_ml"
  ];

  meta = {
    description = "Supercharging Machine Learning";
    homepage = "https://pypi.org/project/comet-ml/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "comet-ml";
  };
}
