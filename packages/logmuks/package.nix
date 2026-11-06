{
  fetchpatch,
  lib,

  gomuks-web,
  gomuks-src,
}:

gomuks-web.overrideAttrs (old: {
  src = old.src // gomuks-src;
  vendorHash = "sha256-OKZLMNPpFIvH/CTg2PKuuze/l0K1x2nNvqea6eCztW8=";
  env = old.env // {
    npmDeps = old.env.npmDeps.overrideAttrs {
      hash = "sha256-esb/B3tXmPWb3o53/wI63EC587+2Z3KEjJeAlES7Oxo=";
    };
  };

  patches = (old.patches or [ ]) ++ [
    (fetchpatch {
      # hicli/jsoncmd,web/api: add support for MSC4441 profile notes
      url = "https://github.com/thetayloredman/logmuks/commit/50496b13333ff4685f2dc825654050ed3b960930.patch";
      hash = "sha256-Q6Maq4WRPV5aZS0ra732i8kTawnkzep7tcJzjz8LxGk=";
    })
    (fetchpatch {
      # web/rightpanel: add profile note rendering
      url = "https://github.com/thetayloredman/logmuks/commit/70ad20cc6137b4bceaab9c3c1534ede5faf481a4.patch";
      hash = "sha256-xQhBFy9lkx4ftLM8aWWyInYu0srx7WALiEXQHSFKM2w=";
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
