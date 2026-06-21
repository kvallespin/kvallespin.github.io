#!/usr/bin/env python3
"""Redact PII from an image by drawing opaque black rectangles, then save.

Use for credential/ID documents before publishing (DOB, personal email, ID/license
numbers, home address, signatures). Always re-fetch the LIVE image after deploy to
confirm the served copy is the redacted one.

Workflow to find exact boxes:
  1. Open the source image and note its size (W, H).
  2. Crop the header/footer regions and view them to measure where the text sits.
  3. Pass generous boxes (x0 y0 x1 y1) so nothing peeks out at the edges.

Examples:
  # inspect size + dump header/footer crops for measuring
  python redact.py inspect SRC.jpg OUTDIR

  # redact: each --box is "x0,y0,x1,y1" (pixels, top-left origin)
  python redact.py redact SRC.jpg OUT.jpg --box 365,145,505,182 --box 655,108,1115,150 --box 48,1568,300,1616
"""
import argparse, os, sys
from PIL import Image, ImageDraw


def inspect(src, outdir):
    im = Image.open(src).convert("RGB")
    W, H = im.size
    os.makedirs(outdir, exist_ok=True)
    im.crop((0, 0, W, min(260, H))).save(os.path.join(outdir, "header.png"))
    im.crop((0, max(0, H - 130), W, H)).save(os.path.join(outdir, "footer.png"))
    print(f"size = {W} x {H}")
    print(f"wrote {outdir}/header.png and {outdir}/footer.png — view them to measure boxes")


def redact(src, out, boxes):
    im = Image.open(src).convert("RGB")
    d = ImageDraw.Draw(im)
    for b in boxes:
        x0, y0, x1, y1 = (int(v) for v in b.split(","))
        d.rectangle((x0, y0, x1, y1), fill=(0, 0, 0))
    im.save(out, quality=88)
    print(f"redacted {len(boxes)} region(s) -> {out}  ({im.size[0]}x{im.size[1]})")


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = p.add_subparsers(dest="cmd", required=True)
    pi = sub.add_parser("inspect"); pi.add_argument("src"); pi.add_argument("outdir")
    pr = sub.add_parser("redact"); pr.add_argument("src"); pr.add_argument("out")
    pr.add_argument("--box", action="append", required=True, help='"x0,y0,x1,y1"')
    a = p.parse_args()
    if a.cmd == "inspect":
        inspect(a.src, a.outdir)
    else:
        redact(a.src, a.out, a.box)


if __name__ == "__main__":
    sys.exit(main())
