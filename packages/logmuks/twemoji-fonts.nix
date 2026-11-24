{
  stdenvNoCC,
  python3,

  twemoji-src,
}:

let
  python = python3.withPackages (ps: with ps; [ nanoemoji ]);
  twemoji-staged = stdenvNoCC.mkDerivation {
    pname = "twemoji-staged";
    version = "unstable";

    dontUnpack = true;

    nativeBuildInputs = [ python ];

    installPhase = ''
      runHook preInstall

      mkdir $out

      for svg in ${twemoji-src}/assets/svg/*.svg; do
        name="$(basename "$svg" .svg | tr '-' '_')"
        ln -s "$svg" "$out/emoji_u''${name}.svg"
      done

      runHook postInstall
    '';
  };
in
stdenvNoCC.mkDerivation {
  pname = "twemoji-fonts";
  version = "unstable";

  dontUnpack = true;

  nativeBuildInputs = [ python ];

  buildPhase = ''
    runHook preBuild

    build_font() {
      format="$1"
      filename="$2"
      work="$TMPDIR/$format"

      mkdir -p "$work"

      (
        cd "$work"

        nanoemoji \
          --color_format "$format" \
          --family "Twemoji" \
          --output_file "$filename" \
          --verbosity 1 \
          ${twemoji-staged}/*.svg
      )

      install -Dm644 \
        "$work/build/$filename" \
        "$out/share/fonts/truetype/$filename"
    }

    echo "Building COLRv0..."
    build_font glyf_colr_0 twemoji-colrv0.ttf

    runHook postBuild
  '';

  installPhase = "true";
}
