{ lib
, runCommand
, fetchFromGitHub
, buildNpmPackage
, imagemagick
, librsvg
, woff2
, ...
}:

let
  browser_wasi_shim = buildNpmPackage {
    pname = "browser_wasi_shim";
    version = "0.4.2";
    src = fetchFromGitHub {
      owner = "haskell-wasm";
      repo = "browser_wasi_shim";
      rev = "0e10ea9465a098d1ee2cf3e09ed050102f0ead1a";
      hash = "sha256-j/UhO3RvTF0NFE8gfbKopjBDdBPn1UdS01PQJixJMZc=";
    };
    npmDepsHash = "sha256-eehX/bQoMo0rfCq6GF4ood0+xbRagMK4gWGXlZtpfJ4=";
    installPhase = ''
      mv dist "$out"
    '';
    meta = {
      description = "A pure javascript shim for WASI";
      homepage = "https://github.com/haskell-wasm/browser_wasi_shim";
      license = with lib.licenses; [ asl20 mit ];
      maintainers = with lib.maintainers; [ ners ];
    };
  };
  favicon = runCommand "favicon.ico"
    {
      nativeBuildInputs = [
        imagemagick
        librsvg
      ];
    }
    ''
      tmpPng="$(mktemp --suffix=.png)"
      rsvg-convert "${./static/icon.svg}" \
        --width 64 \
        --output "$tmpPng"
      convert "$tmpPng" -define icon:auto-resize=64,48,32,16 "$out"
      rm "$tmpPng"
    '';
  apple-touch-icon = runCommand "apple-touch-icon.png"
    {
      nativeBuildInputs = [
        librsvg
      ];
    }
    ''
      rsvg-convert "${./static/icon.svg}" \
        --background-color '#3457D5' \
        --width 180 \
        --output "$out"
    '';
  press-start-2p =
    runCommand
      "press-start-2p"
      {
        nativeBuildInputs = [ woff2 ];
        src = fetchFromGitHub {
          owner = "alexeiva";
          repo = "PressStart2P";
          rev = "82b0adbe05d24ecfe2188807ed23993b0fa63468";
          hash = "sha256-sozNx/4/4H4itRTYNQmPeLZKZVC4L8TMO9MoGcmtyjs=";
        };
      }
      ''
        mkdir -p "$out"
        cd "$out"
        cp -r "$src"/fonts/PressStart2P-Regular.{otf,ttf} .
        woff2_compress PressStart2P-Regular.otf
      '';
in
runCommand "dashi-static-assets" { } ''
  mkdir -p "$out"
  cd "$out"
  cp -r "${./static}" ./static
  cd static
  chmod -R +w .
  cp -r "${browser_wasi_shim}" browser_wasi_shim
  cp -r "${press-start-2p}" PressStart2P
  cd ..
  cp "${favicon}" favicon.ico
  cp "${apple-touch-icon}" apple-touch-icon.png
  mv static/*.html .
''
