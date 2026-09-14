{
  logmuks-src,
  pkgs,
  ...
}:
with pkgs;
buildGoModule (finalAttrs: {
  # modified from https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/go/gomuks-web/package.nix
  pname = "logmuks";
  version = "26.08-main";

  src = logmuks-src;

  proxyVendor = true;
  vendorHash = "sha256-PiYGde5BU3E/0mu5TwjHMq7K4LxnvnCcKhHF7254Xgs=";

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
      hash = "sha256-eZsjp6Nbe5wdyIlsOzjsKfFBb3/lv6oD3ed/08i5dFI=";
    };
  };

  postPatch = ''
    substituteInPlace ./web/build-wasm.sh \
      --replace-fail 'go.mau.fi/gomuks/version.Tag=$(git describe --exact-match --tags 2>/dev/null)' "go.mau.fi/gomuks/version.Tag=v0.2609.0-main" \
      --replace-fail 'go.mau.fi/gomuks/version.Commit=$(git rev-parse HEAD)' "go.mau.fi/gomuks/version.Commit=unknown"
  '';

  doCheck = false;

  tags = [
    "goolm"
    "libheif"
    "sqlite_fts5"
  ];

  ldflags = [
    "-X 'go.mau.fi/gomuks/version.Tag=v0.2609.0-main'"
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
