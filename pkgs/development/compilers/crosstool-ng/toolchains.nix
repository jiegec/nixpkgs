{ stdenv
, lib
, crosstool-ng
, crosstool-ng-fetcher
, cacert
, writeShellScript
}:

let toolchains = import ./configs.nix;
in
(builtins.mapAttrs
  (name: { configFromSample, sourceSha256 }: stdenv.mkDerivation {
    name = "crosstool-ng-toolchain-${name}";
    src = crosstool-ng-fetcher {
      name = "crosstool-ng-${name}-src";
      sha256 = sourceSha256;
      inherit configFromSample;
    };

    builder = writeShellScript "builder.sh" ''
      source $stdenv/setup
      unset CC CXX

      cp -r $src/.config .
      chmod +w .config
      echo CT_LOCAL_TARBALLS_DIR=$src/tarballs >> .config
      echo CT_PREFIX_DIR=$PWD/prefix >> .config

      ct-ng build

      cp -r prefix $out
    '';

    nativeBuildInputs = [ crosstool-ng ];

    # Fix error: '-Wformat-security' when building gcc
    hardeningDisable = [ "format" ];
  })
  toolchains)
