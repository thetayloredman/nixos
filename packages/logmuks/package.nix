{
  fetchpatch,
  fetchurl,
  lib,

  gomuks-web,
  gomuks-src,

  fetchNpmDeps,
}:

let
  twemoji-ttf = fetchurl {
    url = "https://github.com/Sav22999/emoji/raw/11bb6a95c2890599333bc63a15a46b5bd05ea7d5/font/twemoji.ttf";
    hash = "sha256-kaISBpEFPM8RvfX4H9Oej94J7DBE5dFrXd1389GSpUA=";
  };
in
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
    ./0001-web-timeline-add-links-to-referenced-events-in-react.patch
    ./0002-feat-don-t-select-matrix.org-as-the-populated-via.patch
    ./0003-feat-add-room-alias-to-settings-view.patch
    ./0004-add-buttons-to-jump-to-internal-dashboards.patch
    ./0005-composer-always-hide-the-more-obvious-fingerprints.patch
    ./0006-web-add-reportban-option-to-context-menu.patch
  ];

  postPatch = (old.postPatch or "") + ''
    mkdir -p web/public/fonts
    cp ${twemoji-ttf} web/public/fonts/twemoji.ttf
  '';
})
