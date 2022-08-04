{ stdenv
, lib
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "miniaudio";
  version = "unstable-2021-08-22";

  src = fetchFromGitHub {
    owner = "mackron";
    repo = "miniaudio";
    rev = "dbca7a3b44594e0226f887472b31f54aa5f14214";
    sha256 = "sha256-IfxVbfJJIOJT9iR6Io1KcWxcc1RsTSMLqCgEB3blyg8=";
  };

  installPhase = ''
    mkdir -p $out/include/miniaudio
    cp miniaudio.h $out/include/miniaudio/miniaudio.h
  '';

  meta = with lib; {
    description = "A single file library for audio playback and capture.";
    homepage = "https://github.com/mackron/miniaudio";
    license = licenses.publicDomain;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.jiegec ];
  };
}
