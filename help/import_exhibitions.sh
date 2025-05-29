#!/bin/bash

input="$1"
input_pics="$2"

# Skip header
tail -n +2 "$input" | while IFS=';' read -r id year title city notes description; do
  # Remove surrounding quotes, handle escaped double quotes
  title=$(echo "$title" | sed -E 's/^"//;s/"$//' | sed 's/""/"/g')
  city=$(echo "$city" | sed -E 's/^"//;s/"$//' | sed 's/""/"/g')
  notes=$(echo "$notes" | sed -E 's/^"//;s/"$//' | sed 's/""/"/g')
  description=$(echo "$description" | sed -E 's/^"//;s/"$//' | sed 's/""/"/g')

  # Zero-pad id
  padded_id=$(printf "%04d" "$id")

  # Create directory
  mkdir -p "$padded_id"

  # Write index.markdown
  cat > "$padded_id/index.markdown" <<EOF
---
layout: exhibition
title: $title
year: $year
city: $city
EOF

  if [[ -n $description ]]; then
    cat >> "$padded_id/index.markdown" <<EOF
description: $description
EOF
  fi

  if [[ -n $notes ]]; then
    cat >> "$padded_id/index.markdown" <<EOF
notes: $notes
EOF
  fi

  echo "pictures:" >> "$padded_id/index.markdown"
  grep "^" "$input_pics" | tail -n +2 | while IFS=';' read -r pic_id location_id comment; do
    if [[ "$location_id" == "$id" ]]; then
      echo "  - $pic_id" >> "$padded_id/index.markdown"
    fi
  done

  cat >> "$padded_id/index.markdown" <<EOF
---
EOF

done
