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


# build all in one page doc
cat building/SUMMARY.md | grep '(' | awk -F'(' '{print $NF}' | tr -d ')' | while read pth; do
    cat building/$pth
    echo ""
done > building/all-in-one.md



# add table-of-content to every *.md
for i in $(cd building; find . -name "*.md" | grep -v "SUMMARY\|README"); do

    doctoc --title "**Table of Content**" "building/$i" || die adding TOC to "$i"

done

gitbook build -f web building/ dist || die build with gitbook


# build all-in-one.html
pandoc --standalone          \
    -H _include/css.html \
    -f markdown -t html      \
    building/all-in-one.md   \
    --output dist/all-in-one.html || die build all-in-one.html


# build branch: release
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
