#!/usr/bin/env python
"""Simple script to replace a list of regex patterns in the input file.

WARNING: this modifies the input file in place!!! It does leave file~ as a
backup.

Usage::

    replace.py <input filename>
"""

#-----------------------------------------------------------------------------
# Configure here - define replacement list
#-----------------------------------------------------------------------------

patterns = [(r'\\documentclass{article}',
             r'\\documentclass{article}\n  \\usepackage{palatino}'),
             (r'^\s+IPython 2013 Progress Report - Sloan Foundation', ''),
             (r'1.15 million', r'\$1.15 million'),
            ]

# You shouldn't need to configure any further code.

#-----------------------------------------------------------------------------
# Imports
#-----------------------------------------------------------------------------

import os
import re
import sys

#-----------------------------------------------------------------------------
# Main code
#-----------------------------------------------------------------------------

# Compile regexes first. That way, if there's an error in any of them, we fail
# early before touching any files.
replacements = [ (re.compile(pat, re.MULTILINE), rep)
                 for (pat, rep) in patterns ]

# Rename input file, read it in, run over the regexes and write output file
fname = sys.argv[1]
backup = fname+'~'

os.rename(fname, backup)

with open(backup) as fin:
    out = fin.read()

for rx, rep in replacements:
    out = rx.sub(rep, out)

with open(fname, 'w') as f:
    f.write(out)
