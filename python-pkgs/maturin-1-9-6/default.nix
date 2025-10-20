{
  lib,
  buildPythonPackage,
  fetchPypi,
  cargo,
  pkg-config,
  rustPlatform,
  rustc,
  setuptools,
  setuptools-rust,
  tomli,
  bzip2,
  openssl,
  xz,
  zstd,
  stdenv,
  darwin,
  patchelf,
  ziglang,
}:

buildPythonPackage rec {
  pname = "maturin";
  version = "1.9.6";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LCrjcUSBHTZVCYie1yILBZhIfxJ4wkQYKcOr9WzGMko=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-hNFbRtt/sVlEffu7RgXxC1NHzakP8miMyHIV/cf4sfM=";
  };

  build-system = [
    cargo
    pkg-config
    rustPlatform.cargoSetupHook
    rustc
    setuptools
    setuptools-rust
    tomli
  ];

  buildInputs = [
    bzip2
    openssl
    xz
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  dependencies = [
    tomli
  ];

  optional-dependencies = {
    patchelf = [
      patchelf
    ];
    zig = [
      ziglang
    ];
  };

  pythonImportsCheck = [
    "maturin"
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Build and publish crates with pyo3, cffi and uniffi bindings as well as rust binaries as python packages";
    homepage = "https://pypi.org/project/maturin/";
    license = with lib.licenses; [ asl20 mit ];
    maintainers = with lib.maintainers; [ ];
  };
}
