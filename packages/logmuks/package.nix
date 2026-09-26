{
  logmuks-src,
  pkgs,
  ...
}:
with pkgs;
buildGoModule (finalAttrs: {
  # modified from https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/go/gomuks-web/package.nix
  pname = "logmuks";
  version = "69.69";

  src = logmuks-src;

  proxyVendor = true;
  vendorHash = "sha256-zKH3qYXPxJI3WxmfmaEDubqOSPlvhBMgJxvXuLMej7U=";

  nativeBuildInputs = [
    nodejs
    npmHooks.npmConfigHook
    pkg-config
  ];

  buildInputs = [
    libheif
  ];

  env = {
    npmRoot = "web";
    npmDeps = fetchNpmDeps {
      src = "${logmuks-src}/web";
      hash = "sha256-t45wpiuBy9S2UaI/bQJqHOCWn11QWlcEuP7lNrgH90E=";
    };
  };

  postPatch = ''
    substituteInPlace ./web/build-wasm.sh \
      --replace-fail 'go.mau.fi/gomuks/version.Tag=$(git describe --exact-match --tags 2>/dev/null)' "go.mau.fi/gomuks/version.Tag=v0.6969.0" \
      --replace-fail 'go.mau.fi/gomuks/version.Commit=$(git rev-parse HEAD)' "go.mau.fi/gomuks/version.Commit=unknown"
  '';

  doCheck = false;

  tags = [
    "goolm"
    "libheif"
    "sqlite_fts5"
  ];

  ldflags = [
    "-X 'go.mau.fi/gomuks/version.Tag=v0.6969.0'"
    "-X 'go.mau.fi/gomuks/version.Commit=unknown'"
    "-X \"go.mau.fi/gomuks/version.BuildTime=$(date -Iseconds)\""
    "-X \"maunium.net/go/mautrix.GoModVersion=$(cat go.mod | grep 'maunium.net/go/mautrix ' | head -n1 | awk '{ print $2 })\""
  ];

  subPackages = [
    "cmd/gomuks"
    "cmd/gomuks-terminal"
    "cmd/archivemuks"
  ];

  preBuild = ''
    CGO_ENABLED=0 go generate ./web
  '';

  postInstall = ''
    mv $out/bin/gomuks $out/bin/gomuks-web
  '';

  passthru.updateScript = ./update.sh;
})
