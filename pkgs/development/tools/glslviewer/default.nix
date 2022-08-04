{ stdenv
, lib
, fetchFromGitHub
, cmake
, pkg-config
, ffmpeg
, ada
, glfw
, glm
, stb
, skymodel
, libX11
, libXrandr
, libXinerama
, libXcursor
, libXi
, libXext
, libGLU
, miniaudio
, Cocoa
}:

stdenv.mkDerivation rec {
  pname = "glslviewer";
  version = "2.1.2";

  src = fetchFromGitHub {
    owner = "patriciogonzalezvivo";
    repo = "glslViewer";
    rev = version;
    sha256 = "sha256-xCz5aDQ3mEbnY9lou2b8/bfqQvsniHGxVa3JbiNw/g0=";
  };

  NIX_CFLAGS_COMPILE = "-I${stb}/include/stb";

  NIX_LDFLAGS_BEFORE = "-lGL -lglfw -lskymodel -lada";

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [
    ada
    ffmpeg
    glfw
    glm
    libX11
    libXrandr
    libXinerama
    libXcursor
    libXi
    libXext
    libGLU
    miniaudio
    skymodel
  ] ++ lib.optional stdenv.isDarwin Cocoa;

  patches = [
    ./use-external-ada.patch
  ];

  meta = with lib; {
    description = "Live GLSL coding renderer";
    homepage = "http://patriciogonzalezvivo.com/2015/glslViewer/";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.hodapp ];
  };
}
