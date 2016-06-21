#!/bin/bash

ruby create_doc.rb create schemas/berlin_od_schema.json > web/index.html
cp schemas/berlin_od_schema.json web
