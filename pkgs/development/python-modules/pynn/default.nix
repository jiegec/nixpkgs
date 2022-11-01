{ lib
, buildPythonPackage
, fetchPypi
, h5py
, lazyarray
, neo
, numpy
}:

buildPythonPackage rec {
  pname = "PyNN";
  version = "0.10.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-A/uv7d1krnFj4rVXsnYDgLbs61JGnxs/TMIDu7gPDN4=";
  };

  propagatedBuildInputs = [
    lazyarray
    neo
    numpy
  ];

  # fails to create a daemon, probably because of sandboxing
  doCheck = false;

  meta = with lib; {
    description = "A Python package for simulator-independent specification of neuronal network models";
    homepage = "http://neuralensemble.org/PyNN/";
    license = licenses.cecill20;
    maintainers = with maintainers; [ jiegec ];
  };
}
