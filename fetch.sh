#!/bin/bash
OUTPUT_LOCATION=/specs
# List of URLs for specs
RESOURCES=(
    "https://raw.githubusercontent.com/Aman7123/image-sys-api-ac/main/src/generated/api/image-sys-api.yaml"
    "https://raw.githubusercontent.com/Aman7123/rarity-sys-api-ac/main/src/generated/api/rarity-sys-api.yaml")
# Create folders if not exist
mkdir -p $FQWN$OUTPUT_LOCATION
# Loop through the array
for i in "${RESOURCES[@]}"
    do
        echo "FETCHING $i"
        # Download the file
        curl -o $FQWN$OUTPUT_LOCATION/$(basename $i) $i
    done