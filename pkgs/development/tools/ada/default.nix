{ stdenv
, lib
, fetchFromGitHub
, cmake
, ninja
, pkg-config
, ffmpeg
, libX11
, libXrandr
, libXinerama
, libXcursor
, libXi
, libXext
, libGLU
}:

stdenv.mkDerivation rec {
  pname = "ada";
  version = "unstable-2022-03-15";

  src = fetchFromGitHub {
    owner = "patriciogonzalezvivo";
    repo = "ada";
    rev = "a3211ecc442e6ee14b5976d2092563c8b8ade4a0";
    sha256 = "sha256-km47B/2FDIlYGvII8OyvIqQITk1wNCqCqyeicSnaujQ=";
  };

  patches = [
    ./install-lib-headers.patch
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    ffmpeg
    libX11
    libXrandr
    libXinerama
    libXcursor
    libXi
    libXext
    libGLU
  ];

  meta = with lib; {
    description = "An easy cross platform OpenGL ES 2.0 library";
    homepage = "https://github.com/patriciogonzalezvivo/ada";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.jiegec ];
  };
}
