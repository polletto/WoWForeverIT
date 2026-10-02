#!/usr/bin/env python3
"""Build a deterministic addon ZIP; includes only the installable addon folder."""
from pathlib import Path
import argparse
import re
import zipfile

ROOT = Path(__file__).resolve().parents[1]
ADDON = ROOT / "WoWForeverIT"

def package(destination=None):
    toc = (ADDON / "WoWForeverIT.toc").read_text(encoding="utf-8")
    version = re.search(r"^## Version: ([0-9]+\.[0-9]+\.[0-9]+)$", toc, re.M)
    if not version:
        raise ValueError("Missing or invalid TOC version")
    for line in toc.splitlines():
        if line.endswith(".lua") and not (ADDON / line).is_file():
            raise FileNotFoundError(line)
    destination = Path(destination) if destination else ROOT / "dist" / f"WoWForeverIT-beta-{version[1]}.zip"
    destination.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(destination, "w", zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(ADDON.rglob("*")):
            if not path.is_file():
                continue
            info = zipfile.ZipInfo(path.relative_to(ROOT).as_posix(), (2026, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o644 << 16
            archive.writestr(info, path.read_bytes())
    print(destination)
    return destination

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", help="Optional output ZIP path")
    package(parser.parse_args().output)
