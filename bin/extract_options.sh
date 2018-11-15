#!/bin/bash

extract_options() {
    PROP_NAME=$1
    VALUE_PATH=$2
    OUT_FOLDER=$3
    echo "extracting and writing values for property '$PROP_NAME$VALUE_PATH'"
    cat schemas/berlin_od_schema.json | \
    # no need to grab this remotely - the source is right here locally
    # curl -s https://datenregister.berlin.de/schema/berlin_od_schema.json | \
        jq -r ".properties.$PROP_NAME$VALUE_PATH" | jq -r '.enum as $ids | (.labels // .enum) as $labels | reduce range(0; $labels|length) as $i (""; . + "\($ids[$i])|\($labels[$i])\n" )' | \
        sed 's/^\(.*\)|\(.*\)$/<option value="\1">\2<\/option>/g' > $OUT_FOLDER/$PROP_NAME.htms
}

OUT_FOLDER=$1
if [ ! -d "$OUT_FOLDER" ]; then
    echo "cannot find directory $OUT_FOLDER"
    echo
    exit
fi
extract_options "geographical_granularity" "" $OUT_FOLDER
extract_options "geographical_coverage" "" $OUT_FOLDER
extract_options "temporal_granularity" "" $OUT_FOLDER
extract_options "license_id" "" $OUT_FOLDER
extract_options "groups" ".items.properties.name" $OUT_FOLDER
