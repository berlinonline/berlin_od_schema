#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}" )

ruby "$DIR/create_doc.rb" create schemas/berlin_od_schema.json > web/index.html
cp schemas/berlin_od_schema.json web
