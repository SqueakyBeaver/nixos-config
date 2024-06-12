{ python3, fetchPypi, lib, zlib, ... }:
python3.pkgs.buildPythonPackage rec {
  pname = "pyinstaller";
  version = "6.6.0";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-vmvCwwc9PoT7cUjTrzPOm2p/Ac+xVOBjFM0dTAV5ijI=";
  };
  doCheck = false;
  propagatedBuildInputs = with python3.pkgs; [
    (lib.getDev zlib)
    altgraph
    packaging
    setuptools # No module named 'pkg_resources'
    # Not sure if needed.
    pkginfo
    importlib-metadata
  ];
}
