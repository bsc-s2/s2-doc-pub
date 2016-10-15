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
cat building/SUMMARY.md | grep -v 'all-in-one.md' | grep '(' | awk -F'(' '{print $NF}' | tr -d ')' | while read pth; do
    cat building/$pth
    echo ""
done > building/all-in-one.md


# # build pdf, it does not need manually created table-of-content.
# # disabled for now. FAQ is not completed.
# gitbook pdf building/ dist/s2-doc.pdf || die build pdf with gitbook


# add table-of-content to every *.md
for i in $(cd building; find . -name "*.md" | grep -v "SUMMARY\|README"); do

    python2 mdtoc.py "building/$i" "building/$i" || die adding TOC to "$i"

done


gitbook build -f web building/ dist || die build html with gitbook


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
