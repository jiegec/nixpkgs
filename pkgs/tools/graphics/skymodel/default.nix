{ stdenv
, lib
, fetchurl
, unzip
, cmake
}:

stdenv.mkDerivation rec {
  pname = "skymodel";
  version = "1.4a";

  src = fetchurl {
    url = "https://cgg.mff.cuni.cz/projects/SkylightModelling/HosekWilkie_SkylightModel_C_Source.1.4a.zip";
    sha256 = "sha256-dD6Bp/y+0GQISQowPc8TFQg9eYihH8aWCOZvblQX+d4=";
  };

  nativeBuildInputs = [
    cmake
    unzip
  ];

  patches = [
    ./add-cmakelists.patch
  ];

  unpackPhase = ''
    unzip $src
    mv HosekWilkie_SkylightModel_C_Source.1.4a/* .
  '';

  meta = with lib; {
    description = "A sample implementation of the analytical skylight and solar radiance models";
    homepage = "https://cgg.mff.cuni.cz/projects/SkylightModelling/";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.jiegec ];
  };
}
