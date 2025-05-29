#!/bin/bash

src_dir="../old/db/gallery_painting"

# Loop through all *_th.jpg files in the source directory
for thumb_file in "$src_dir"/*_th.jpg; do
  # Extract the ID from the filename (remove path and suffix)
  filename=$(basename "$thumb_file")
  id="${filename%_th.jpg}"

  # Define source filenames
  full_src="$src_dir/$id.jpg"
  thumb_src="$src_dir/${id}_th.jpg"

  # Define destination directory
  dest_dir="$id"

  # Only proceed if destination directory exists
  if [ -d "$dest_dir" ]; then
    cp "$full_src" "$dest_dir/full.jpg"
    cp "$thumb_src" "$dest_dir/th.jpg"
  else
    echo "Warning: directory $dest_dir does not exist, skipping $id"
  fi
done

