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

die() {
    echo "ERROR: $@" >&2
    exit 1
}

BUILDING='building/'
DIST='dist/'

rm -rf $BUILDING
mkdir $BUILDING || die mkdir $BUILDING

# adding toc changes src files
cp -R src/* $BUILDING || die copy to $BUILDING

for language in $(ls $BUILDING); do

    # build pdf, it does not need manually created table-of-content.
    gitbook pdf $BUILDING/$language s2-doc.pdf || die build pdf with gitbook

    # build all in one page doc
    cat $BUILDING/$language/SUMMARY.md | grep -v 'all-in-one.md\|toolkit' | grep '(' \
                                    | awk -F'(' '{print $NF}' | tr -d ')' | while read pth; do
        cat $BUILDING/$language/$pth
        echo ""
    done > $BUILDING/$language/all-in-one.md

    # add table-of-content to every *.md
    for i in $( cd $BUILDING/$language; find . -name "*.md" | grep -v "SUMMARY\|README" ); do
        python2 mdtoc.py "$BUILDING/$language/$i" "$BUILDING/$language/$i" || die adding TOC to "$language/$i"
    done

    gitbook build -f web $BUILDING/$language $DIST/$language || die build html with gitbook
    mv s2-doc.pdf DIST/$language

done

# build branch: release
git checkout release || die checkout release
rm -rf building/     || die rm building/

for language in $(ls $DIST); do

    # remove everything those are not in dist/
    for p in $(ls $DIST/$language); do
        rm -rf "$language/$p" || die rm -rf "$language/$p"
    done

    mv $DIST/$language/* $language/
done

rm -rf dist/          || die rmdir dist/
git add .            || die git-add .
git add -u .         || die git-add -u .

git commit -m "build release from master $(git rev-parse --short master) $(git log --format="%cd" master -n1)" \
    || die git-commit
