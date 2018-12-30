#!/bin/bash

if [ ! -d "json-schema-spec" ]; then
    git clone https://github.com/json-schema-org/json-schema-spec.git
    (cd json-schema-spec && make)
fi

mkdir -p epub/EPUB epub/META-INF
echo "application/epub+zip" > epub/mimetype
cp container.xml epub/META-INF/
cp package.opf epub/EPUB/
cp json-schema-spec/*.html epub/EPUB/
cp toc.html cover.html epub/EPUB/
(cd epub && zip -0 -X ../json-schema.epub mimetype && zip -r ../json-schema.epub . -x mimetype)

