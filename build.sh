#!/bin/sh

for i in $(cd src; find . -name "*.md"); do

    pandoc --standalone         \
        -H src/_inc/css.html    \
        -f markdown -t html     \
        --toc --toc-depth=5     \
        src/$i                  \
        --output dist/${i%.*}.html

done
