{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  dulwich,
  everett,
  importlib-metadata,
  jsonschema,
  psutil,
  python-box,
  requests,
  requests-toolbelt,
  rich,
  semantic-version,
  sentry-sdk,
  simplejson,
  urllib3,
  wrapt,
  wurlitzer,
  
  # eigene packages
  everett
}:

buildPythonPackage rec {
  pname = "comet-ml";
  version = "3.53.1";
  pyproject = true;

  src = fetchPypi {
    pname = "comet_ml";
    inherit version;
    hash = "sha256-r3abmDqYzJOtdYswe4jK6xkVqGNtzUgSIAMtCLW5rBI=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
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
  };
}
