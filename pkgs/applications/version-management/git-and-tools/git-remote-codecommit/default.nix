{ lib, buildPythonApplication, fetchFromGitHub, isPy3k, botocore, pytest, mock
, flake8, tox, awscli }:

buildPythonApplication rec {
  pname = "git-remote-codecommit";
  version = "1.16";
  disabled = !isPy3k;

  src = fetchFromGitHub {
    owner = "aws";
    repo = pname;
    rev = version;
    sha256 = "sha256-E7ffy4G6KsfTX6tjg2nP2FGDBqGK+0a9nVEc/rDhmXM=";
  };

  propagatedBuildInputs = [ botocore ];

  checkInputs = [ pytest mock flake8 tox awscli ];

  checkPhase = ''
    pytest
  '';

  meta = {
    description =
      "Git remote prefix to simplify pushing to and pulling from CodeCommit";
    maintainers = [ lib.maintainers.zaninime ];
    homepage = "https://github.com/awslabs/git-remote-codecommit";
    license = lib.licenses.asl20;
  };
}
