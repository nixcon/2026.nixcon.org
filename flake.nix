{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-wasm = {
      url = "github:ners/nix-wasm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    miso = {
      url = "github:haskell-miso/miso";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dramaturge = {
      url = "github:ners/dramaturge";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with builtins;
    let
      inherit (inputs.miso.inputs.nixpkgs) lib;
      foreach = xs: f: with lib; foldr recursiveUpdate { } (
        if isList xs then map f xs
        else if isAttrs xs then mapAttrsToList f xs
        else throw "foreach: expected list or attrset but got ${typeOf xs}"
      );
      sourceFilter = root: with lib.fileset; toSource {
        inherit root;
        fileset = fileFilter
          (file: any file.hasExt [ "cabal" "hs" "md" ])
          root;
      };
      projects =
        with lib;
        genAttrs' (fileset.toList (fileset.fileFilter (file: file.hasExt "cabal") ./.)) (
          file: nameValuePair (removeSuffix ".cabal" (baseNameOf file)) (dirOf file)
        );
      pnames = lib.attrNames projects;
      pname = "nixcon-website";
      ghc = "ghc912";
      haskell-overlay = pkgs: with pkgs.haskell.lib.compose; lib.composeManyExtensions [
        (inputs.dramaturge.overlays.haskell pkgs)
        (hfinal: hprev: lib.mapAttrs (pname: dir: hfinal.callCabal2nix pname (sourceFilter dir) { }) projects)
        (hfinal: hprev: {
          ${pname} = hprev.${pname} // {
            staticAssets = pkgs.callPackage ./static-assets.nix { inherit inputs; };
          };
          nixcon-website-export = hprev.nixcon-website-export.overrideAttrs (attrs: {
            nativeBuildInputs = [ pkgs.makeWrapper ] ++ attrs.nativeBuildInputs or [ ];
            postInstall = ''
              ${attrs.postInstall or ""}
              wrapProgram "$out"/bin/export --prefix PATH : "${lib.makeBinPath [pkgs.firefox]}"
            '';
          });
          # jsaddle-wasm = addBuildDepend hfinal.parser-regex hprev.jsaddle-wasm;
          miso = enableCabalFlag "template-haskell" (hfinal.callCabal2nix "miso" inputs.miso { });
          feedback = hfinal.callCabal2nix "feedback"
            (pkgs.fetchFromGitHub
              {
                owner = "NorfairKing";
                repo = "feedback";
                rev = "5ec59759d4252f8d1c38c8b5e5580f543390a40e";
                hash = "sha256-kW0KtUZxF8xeccwCEfakS9PxrcVICVTuMH2QofYZYdI=";
              } + "/feedback")
            { };
        })
        (hfinal: hprev: lib.optionalAttrs (hprev.ghc.targetPrefix == "wasm32-wasi-") {
          ${pname} = appendBuildFlag "--ghc-options=-DWASM" hprev.${pname} // {
            inherit (hprev.${pname}) staticAssets;
            dist = pkgs.runCommand "${pname}-wasm-dist"
              {
                nativeBuildInputs = with pkgs; [
                  binaryen
                  brotli
                  hfinal.ghc
                  nodejs
                  wasm-tools
                  webpack-cli
                ];
              }
              ''
                function compare() {
                  echo "$1: $(numfmt --to=si --suffix=B $2) -> $(numfmt --to=si --suffix=B $3) ($(( $3 * 100 / $2 - 100 ))%)"
                }
                function compress() {
                    f1="$1"
                    shift
                    f2="$1"
                    shift
                    size1="$(cat $f1 | wc -c)"
                    gzip1="$(gzip -c $f1 | wc -c)"
                    brotli1="$(brotli -c $f1 | wc -c)" || true
                    eval "$*"
                    size2="$(cat $f2 | wc -c)"
                    gzip2="$(gzip -c $f2 | wc -c)"
                    brotli2="$(brotli -c $f2 | wc -c)" || true
                    compare $f2 $size1 $size2
                    compare $f2.gz $gzip1 $gzip2
                    compare $f2.br $brotli1 $brotli2
                }
                mkdir -p "$out"
                cd "$out"
                cp -r "${hfinal.${pname}.staticAssets}"/* .
                chmod -R +w .
                cd static
                cp "${hfinal.${pname}}/bin/"*.wasm app.wasm
                chmod +w app.wasm
                "$(wasm32-wasi-ghc --print-libdir)"/post-link.mjs --input app.wasm --output ghc_wasm_jsffi.js
                # hold @MagicRB accountable for this crime
                sed -i 's/var runBatch = /var initialSyncDepth = 0; &/' ghc_wasm_jsffi.js

                compress app.wasm{,} "wasm-opt -all -O2 -o app.wasm{,} ; wasm-tools strip -o app.wasm{,}"

                substituteInPlace ghc_wasm_jsffi.js --replace-fail "node:timers" timers
                entries="./main.js ./ghc_wasm_jsffi.js ./browser_wasi_shim/*.js"
                compress "$entries" main.js webpack --config "${pkgs.writeText "webpack.config.js" /*javascript*/ ''
                  module.exports = {
                    resolve: {
                      fallback: {
                        timers: false, // do not include a polyfill for node:timers
                      },
                    },
                  };
                ''}" --mode production --output-path . --entry $entries
                rm -fr ghc_wasm_jsffi.js browser_wasi_shim
                cd ..
                sed -i "s/\?v=0/\?v=$(md5sum static/app.wasm | cut -d' ' -f1)/" index.html static/main.js
              '';
          };
        })
      ];
      overlay = lib.composeManyExtensions [
        (final: prev: {
          haskell = prev.haskell // {
            packageOverrides = lib.composeManyExtensions [
              prev.haskell.packageOverrides
              (haskell-overlay final)
            ];
          };
        })
      ];
      extendHaskellPackages = nativePkgs: pkgs:
        let extend = ps: ps.extend (haskell-overlay nativePkgs); in pkgs // {
          haskellPackages = extend pkgs.haskellPackages;
          haskell = pkgs.haskell // { packages = lib.mapAttrs (_: extend) pkgs.haskell.packages; };
        };
    in
    {
      overlays = {
        default = overlay;
        haskell = haskell-overlay;
      };
    }
    //
    foreach inputs.nixpkgs.legacyPackages (system: pkgs':
      let
        pkgs = pkgs'.extend overlay;
        wasmPkgs = extendHaskellPackages pkgs inputs.nix-wasm.legacyPackages.${system};
      in
      {
        packages.${system} = rec {
          default = static;
          static = pkgs.runCommand "nixcon-website"
            {
              nativeBuildInputs = with pkgs; [ http-server ];
            } ''
            cp -r "${wasmPkgs.haskell.packages.${ghc}.${pname}.staticAssets}" "$out"
            cd "$out"
            chmod -R +w .
            rm -rf static/browser_wasi_shim static/main.js
            export HOME=$TMPDIR
            http-server "${wasmPkgs.haskell.packages.${ghc}.${pname}.dist}" --brotli --gzip &
            "${pkgs.haskellPackages.nixcon-website-export}"/bin/export
            find -name "*.html" -exec sed -i '/\/static\/main.js/d' {} +
          '';
          wasmServer = pkgs.writeShellApplication {
            name = "${pname}-wasm-server";
            runtimeInputs = [ pkgs.http-server ];
            text = ''
              http-server "${wasmPkgs.haskell.packages.${ghc}.${pname}.dist}" --brotli --gzip
            '';
          };
          staticServer = pkgs.writeShellApplication {
            name = "${pname}-static-server";
            runtimeInputs = [ pkgs.http-server ];
            text = ''
              http-server "${static}" --brotli --gzip
            '';
          };
        };
        legacyPackages.${system} = pkgs // {
          inherit wasmPkgs;
        };
        devShells.${system}.default = pkgs.mkShell {
          inputsFrom = [
            (wasmPkgs.haskellPackages.shellFor {
              packages = ps: [ ps.${pname} ];
              nativeBuildInputs = with wasmPkgs; [
                cabal-install
              ];
            })
            (pkgs.haskell.packages.${ghc}.shellFor {
              packages = ps: map (pname: ps.${pname}) pnames;
              nativeBuildInputs = with pkgs; [
                firefox
                haskell.packages.${ghc}.haskell-language-server
                haskellPackages.cabal-install
                haskellPackages.feedback
                http-server
                nodejs
              ];
            })
          ];
        };
        formatter.${system} = pkgs.writeShellApplication {
          name = "formatter";
          runtimeInputs = with pkgs; with haskellPackages; [
            cabal-gild
            fd
            fourmolu
            nixpkgs-fmt
          ];
          text = ''
            fd --extension=nix -X nixpkgs-fmt
            fd --extension=hs -X fourmolu -i
            fd --extension=cabal -x cabal-gild --io
          '';
        };
      }
    );
}
