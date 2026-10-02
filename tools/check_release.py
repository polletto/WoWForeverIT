#!/usr/bin/env python3
"""Reject a release tag unless it matches the installable addon's TOC version."""
import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def check(tag):
    toc = (ROOT / 'WoWForeverIT' / 'WoWForeverIT.toc').read_text(encoding='utf-8')
    match = re.search(r'^## Version: ([0-9]+\.[0-9]+\.[0-9]+)$', toc, re.M)
    if not match or tag != f'v{match[1]}':
        raise ValueError('Release tag must be vX.Y.Z and match the TOC version')
    return match[1]

if __name__ == '__main__':
    version = check(os.environ.get('RELEASE_TAG', ''))
    if output := os.environ.get('GITHUB_OUTPUT'):
        with open(output, 'a', encoding='utf-8') as stream:
            stream.write(f'version={version}\ntag=v{version}\n')
    print(f'Validated release v{version}')
