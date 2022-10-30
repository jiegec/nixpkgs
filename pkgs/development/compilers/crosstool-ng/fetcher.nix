{ stdenv
, lib
, crosstool-ng
, cacert
, writeShellScript
, preferLocalBuild ? true
}:

{ name
, sha256
  # use config from samples
, configFromSample ? ""
  # provide config content
, configContent ? ""
}:

stdenv.mkDerivation {
  inherit name;
  builder = writeShellScript "builder.sh" ''
    source $stdenv/setup
    unset CC CXX
    if [ ! -z "${configFromSample}" ]
    then
      ct-ng ${configFromSample}
    else
      echo "${configContent}" > .config
    fi

    # override folders in config
    mkdir -p tarballs
    echo CT_LOCAL_TARBALLS_DIR=$PWD/tarballs >> .config
    echo CT_PREFIX_DIR=$PWD/prefix >> .config

    ct-ng source
    mkdir -p $out
    cp -r tarballs $out/
    cp .config $out/
  '';

  nativeBuildInputs = [ crosstool-ng cacert ];
  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = sha256;

  impureEnvVars = lib.fetchers.proxyImpureEnvVars;

  inherit preferLocalBuild;
}

