#!/bin/bash

input="$1"

# Skip the header and read each line
tail -n +2 "$input" | while IFS=',' read -r id section_id year technique_id width height available price last_modified lang1 id2 title lang2 section_id2 name; do
  # Zero-pad the ID to 4 digits
  padded_id=$(printf "%04d" "$id")

  # Create the directory
  mkdir -p "$padded_id"

  # Create the index.markdown file with the required content
  cat > "$padded_id/index.markdown" <<EOF
---
layout: painting
id: $id
title: $title
year: $year
category: $section_id
technique: $technique_id
width: $width
height: $height
EOF

  if [[ $available == 1 ]]; then
    cat >> "$padded_id/index.markdown" <<EOF
price: $price
EOF
  fi

  cat >> "$padded_id/index.markdown" <<EOF
---
EOF

done
