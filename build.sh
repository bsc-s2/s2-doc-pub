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
#       $ sudo ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin

die()
{
    echo "ERROR: $@" >&2
    exit 1
}


rm -rf building
mkdir building || die mkdir building


# adding toc changes src files
cp -R src/* building/ || die copy to building/


# build pdf, it does not need manually created table-of-content.
gitbook pdf building/ s2-doc.pdf || die build pdf with gitbook


# build all in one page doc
cat building/SUMMARY.md | grep -v 'all-in-one.md\|toolkit' | grep '(' | awk -F'(' '{print $NF}' | tr -d ')' | while read pth; do
    cat building/$pth
    echo ""
done > building/all-in-one.md


# add table-of-content to every *.md
for i in $(cd building; find . -name "*.md" | grep -v "SUMMARY\|README"); do

    python2 mdtoc.py "building/$i" "building/$i" || die adding TOC to "$i"

done


gitbook build -f web building/ dist || die build html with gitbook
mv s2-doc.pdf dist/


# build branch: release
git checkout release || die checkout release
rm -rf building/     || die rm building/


# remove everything those are not in dist/
for p in $(ls dist/); do
    rm -rf "$p" || die rm -rf "$p"
done


mv dist/* .          || die mv dist/xx
rmdir dist/          || die rmdir dist/
git add .            || die git-add .
git add -u .         || die git-add -u .

git commit -m "build release from master $(git rev-parse --short master) $(git log --format="%cd" master -n1)" \
    || die git-commit
