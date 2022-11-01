{ lib
, buildPythonPackage
, fetchPypi
, numpy
}:

buildPythonPackage rec {
  pname = "lazyarray";
  version = "0.5.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-/jGATYIRXtfDgoQKFwj0mEGewUVcrAhHB+zpkIMQx9E=";
  };

  propagatedBuildInputs = [
    numpy
  ];

  meta = with lib; {
    description = "a Python package that provides a lazily-evaluated numerical array class, larray, based on and compatible with NumPy arrays";
    homepage = "https://github.com/NeuralEnsemble/lazyarray/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ jiegec ];
  };
}
