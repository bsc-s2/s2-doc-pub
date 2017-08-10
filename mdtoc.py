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
    reduce_level = None
    level_index = []
    for i, line in enumerate(lines[:]):

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

        origin_level = level

        text = line.strip()

        header_id = re.sub(ur'[,?_*()&]', '', text)
        header_id = re.sub(ur'[^0-9a-zA-Z_\u00ff-\uffff]', '-', header_id)
        header_id = header_id.lower()

        if text.startswith('1.'):
            has_number = True
            text = text[2:]
        else:
            has_number = False

        # reduce all levels if the first header is at level >1

        if reduce_level is None:
            if level > 1:
                reduce_level = level - 1
            else:
                reduce_level = 0

        if reduce_level is not None:
            level = max(1, level - reduce_level)

        if has_number:

            if level < len(level_index):
                level_index = level_index[:level]
            elif level > len(level_index):
                if len(level_index) < level:
                    level_index += [1] * (level - len(level_index) - 1) + [0]

            level_index[-1] += 1

            level_str = '.'.join([str(x) for x in level_index]) + '. '

        else:
            level_str = ''

        text = level_str + text

        if has_number:
            lines[i] = '#' * origin_level + text

        headers.append((level, text, header_id, has_number))

    # output
    toc = []
    for level, text, header_id, has_number in headers:

        s = ' ' * 4 * (level-1) + u'- [{text}](#{header_id})'.format(
                text=text, header_id=header_id)
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
