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
    echo "ERROR: $@" >&2
    exit 1
}

rm -rf building
mkdir building || die mkdir building

# adding toc changes src files
cp -R src/* building/ || die copy to building/

# add table-of-content to every *.md
for i in $(cd building; find . -name "*.md" | grep -v "SUMMARY\|README"); do

    doctoc --title "**Table of Content**" "building/$i" || die adding TOC to "$i"

done

gitbook build -f web building/ dist || die build with gitbook

git checkout release || die checkout release
rm -rf building/     || die rm building/

for p in $(ls dist/); do
    rm -rf "$p" || die rm -rf "$p"
done

mv dist/* .          || die mv dist/xx
rmdir dist/          || die rmdir dist/
git add .            || die git-add .
git add -u .         || die git-add -u .

git commit -m "build release from master $(git rev-parse master)" \
    || die git-commit
