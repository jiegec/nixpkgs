{ stdenv, lib, fetchurl, fetchpatch, autoreconfHook, xz, buildPackages }:

stdenv.mkDerivation rec {
  pname = "libunwind";
  version = "1.7.2";

  src = fetchurl {
    url = "https://github.com/libunwind/libunwind/releases/download/v${version}/libunwind-${version}.tar.gz";
    sha256 = "sha256-oYpqJDB0Q6is56isws55+75oJs0O35jWMm0CJdal1uY=";
  };

  postPatch = if (stdenv.cc.isClang || stdenv.hostPlatform.isStatic) then ''
    substituteInPlace configure.ac --replace "-lgcc_s" ""
  '' else lib.optionalString stdenv.hostPlatform.isMusl ''
    substituteInPlace configure.ac --replace "-lgcc_s" "-lgcc_eh"
  '';

  nativeBuildInputs = [ autoreconfHook ];

  outputs = [ "out" "dev" "devman" ];

  # Without latex2man, no man pages are installed despite being
  # prebuilt in the source tarball.
  configureFlags = [ "LATEX2MAN=${buildPackages.coreutils}/bin/true" ];

  propagatedBuildInputs = [ xz ];

  postInstall = ''
    find $out -name \*.la | while read file; do
      sed -i 's,-llzma,${xz.out}/lib/liblzma.la,' $file
    done
  '';

  doCheck = false; # fails

  meta = with lib; {
    homepage = "https://www.nongnu.org/libunwind";
    description = "A portable and efficient API to determine the call-chain of a program";
    maintainers = with maintainers; [ orivej ];
    # https://github.com/libunwind/libunwind#libunwind
    platforms = [ "aarch64-linux" "armv5tel-linux" "armv6l-linux" "armv7a-linux" "armv7l-linux" "i686-freebsd13" "i686-linux" "mips64el-linux" "mipsel-linux" "powerpc64-linux" "powerpc64le-linux" "riscv64-linux" "loongarch64-linux" "x86_64-freebsd13" "x86_64-linux" "x86_64-solaris" ];
    license = licenses.mit;
  };
}
