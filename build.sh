#!/bin/sh

# requires:
#
#   nodejs
#       $ brew install nodejs
#
#   gitbook
#       $ npm install gitbook
#
#   ebook-convert
#       install calibre.app
#       $ sudo ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/bin
#
#   doctoc # to generate table-of-content
#       $ npm install doctoc

die()
{
    echo "$@" >&2
    exit 1
}

rm -rf building
mkdir building || die mkdir building

# adding toc changes src files
cp -R src/* building/ || die copy to building/

# add table-of-content to every *.md
for i in $(cd building; find . -name "*.md" | grep -v "SUMMARY\|README"); do

    doctoc "building/$i" || die adding TOC to "$i"

done

gitbook build -f web building/ dist || die build with gitbook
