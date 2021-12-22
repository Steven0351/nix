{ lib, stdenv, fetchFromGitHub, pkgs, runCommand, gcc11 }:

stdenv.mkDerivation rec {
  pname = "btop";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "aristocratos";
    repo = pname;
    rev = "v${version}";
    sha256 = "uKR1ogQwEoyxyWBiLnW8BsOsYgTpeIpKrKspq0JwYjY=";
  };

  nativeBuildInputs =
    lib.optionals stdenv.isDarwin [ gcc11 ];

  ADDFLAGS = with pkgs.darwin.apple_sdk;
    lib.optional stdenv.isDarwin
    "-F${frameworks.IOKit}/Library/Frameworks/";

  buildInputs = with pkgs.darwin.apple_sdk;
    lib.optionals stdenv.isDarwin [
      frameworks.CoreFoundation
      frameworks.IOKit
    ] ++ lib.optional (stdenv.isDarwin && !stdenv.isAarch64) (
      # Found this explanation for needing to create a header directory for libproc.h alone.
      # https://github.com/NixOS/nixpkgs/blob/049e5e93af9bbbe06b4c40fd001a4e138ce1d677/pkgs/development/libraries/webkitgtk/default.nix#L154
      # TL;DR, the other headers in the include path for the macOS SDK is not compatible with the C++ stdlib and causes issues, so we copy
      # this to avoid those issues
      runCommand "${pname}_headers" { } ''
        install -Dm444 "${lib.getDev sdk}"/include/libproc.h "$out"/include/libproc.h
      ''
    );

  installFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "A monitor of resources";
    homepage = "https://github.com/aristocratos/btop";
    changelog = "https://github.com/aristocratos/btop/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    platforms = platforms.darwin;
    maintainers = with maintainers; [ rmcgibbo ];
  };
}