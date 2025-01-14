{ lib
, buildPythonPackage
, click
, cloudpickle
, dask
, fetchFromGitHub
, jinja2
, locket
, msgpack
, packaging
, psutil
, pythonOlder
, pyyaml
, setuptools
, setuptools-scm
, sortedcontainers
, tblib
, toolz
, tornado
, urllib3
, versioneer
, wheel
, zict
}:

buildPythonPackage rec {
  pname = "distributed";
  version = "2023.8.0";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "dask";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-FvNh7gfxUR1iIUY3kMolhzcbWupQL39E9JXWip8bdrQ=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace 'dynamic = ["version"]' 'version = "${version}"'
  '';

  nativeBuildInputs = [
    setuptools
    setuptools-scm
    versioneer
  ];

  propagatedBuildInputs = [
    click
    cloudpickle
    dask
    jinja2
    locket
    msgpack
    packaging
    psutil
    pyyaml
    sortedcontainers
    tblib
    toolz
    tornado
    urllib3
    zict
  ];

  # When tested random tests would fail and not repeatably
  doCheck = false;

  pythonImportsCheck = [
    "distributed"
  ];

  meta = with lib; {
    description = "Distributed computation in Python";
    homepage = "https://distributed.readthedocs.io/";
    changelog = "https://github.com/dask/distributed/blob/${version}/docs/source/changelog.rst";
    license = licenses.bsd3;
    maintainers = with maintainers; [ teh ];
  };
}
