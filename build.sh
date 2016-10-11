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

# build online web doc
while read pth; do

    gitbook build -f web building/$pth dist/$pth || die build with gitbook "$pth"

done <<-END
imgx
s2
END


exit $?


for i in $(cd building; find . -name "*.md"); do

    pandoc --standalone         \
        -H building/_inc/css.html    \
        -f markdown -t html     \
        --toc --toc-depth=5     \
        building/$i                  \
        --output dist/${i%.*}.html

done
