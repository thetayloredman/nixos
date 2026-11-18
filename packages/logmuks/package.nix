{
  fetchpatch,
  lib,

  gomuks-web,
  gomuks-src,

  fetchNpmDeps,
}:

gomuks-web.overrideAttrs (old: {
  src = old.src // gomuks-src;
  vendorHash = "sha256-Qp431FgpBvPVo1DkG13Qy3Hv/vbMtgKn6vS6CD9anXc=";
  env = old.env // {
    npmDeps = fetchNpmDeps {
      src = "${gomuks-src}/web";
      hash = "sha256-gwkb3tGhmcbfclJMIO8rTOexzFfUFOmYE93vdgwUK/Y=";
    };
  };

  patches = (old.patches or [ ]) ++ [
    (fetchpatch {
      # add support for MSC4441 profile notes
      url = "https://github.com/gomuks/gomuks/pull/744.patch";
      hash = "sha256-6yxReEh+rbl/sqh7R7r6kRqflIrH8Ob9g/vMqbrfIpw=";
    })
    (fetchpatch {
      # banners idk
      url = "https://git.squarebowl.club/plate/gomuks/commit/7ab5263153a55f25bb288b126964b1fcbee8e550.patch";
      hash = "sha256-Sc13mAyaqgrzOvGqvQ3FJ1scHy4+RFg6xaOE7kP/tuo=";
    })
    (fetchpatch {
      # banner fix
      url = "https://git.squarebowl.club/plate/gomuks/commit/ea55d607bc17efb4e90eb4dd4a154e6a70570d8c.patch";
      hash = "sha256-t3tFRvSsbUwE3rKVZWzsZgx0ZRzRVzoXJJXciOVLIVA=";
    })
    (fetchpatch {
      # more banner
      url = "https://git.squarebowl.club/plate/gomuks/commit/03a8161512d4bbd620f6aa7c91baa63818fe0ff1.patch";
      hash = "sha256-xSbJQib9f6On7MxDZ4FP83IrM436+GpyMtOjCwxeqKI=";
    })
    ./01-reference-links.patch
    ./02-the-demorgenning.patch
    ./03-add-room-alias-to-settings.patch
    ./04-internal-dashboards.patch
    ./05-hide-fingerprint.patch
  ];
})
