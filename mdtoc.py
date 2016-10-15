#!/usr/bin/env python
# coding: utf-8

import re
import os
import sys
import json

toc_start = u'<!-- mdtoc start -->'
toc_end   = u'<!-- mdtoc end   -->'

def add_md_toc(path):

    with open(path, 'r') as f:
        cont = f.read()

    cont = cont.decode('utf-8')
    _lines = cont.split('\n')

    lines = []

    # remove old mdtoc
    found = False
    for l in _lines:

        if l == toc_start:
            found = True
            continue
        elif l == toc_end:
            found = False
            continue

        if not found:
            lines.append(l)

    # find out all headers
    headers = []
    isblock = False
    for line in lines:

        if line.strip().startswith('```'):
            isblock = not isblock

        if isblock:
            continue

        if not line.startswith('#'):
            continue

        level = 0
        while len(line) > 0 and line.startswith('#'):
            level += 1
            line = line[1:]

        text = line.strip()

        header_id = re.sub(ur'[,?_*()&]', '', text)
        header_id = re.sub(ur'[^0-9a-zA-Z_\u00ff-\uffff]', '-', header_id)
        header_id = header_id.lower()

        headers.append((level, text, header_id))

    # reduce level
    if len(headers) == 0 or headers[0][0] == 1:
        pass
    else:
        reduce_level = headers[0][0] - 1
        headers = [(max(1, x[0] - reduce_level),
                    x[1],
                    x[2])
                   for x in headers]

    # output
    toc = []
    for level, text, header_id in headers:
        s = ' ' * 4 * (level-1) + u'- [{text}](#{header_id})'.format(text=text, header_id=header_id)
        toc.append(s)

    return ( toc_start + u'\n'
            + u'\n'.join(toc) + u'\n'
            + u'\n\n'
            + toc_end + u'\n'
            + u'\n'.join(lines)
    )


if __name__ == "__main__":

    path, dst = sys.argv[1:3]

    cont = add_md_toc(path)

    with open(dst, 'w') as f:
        f.write(cont.encode('utf-8'))
