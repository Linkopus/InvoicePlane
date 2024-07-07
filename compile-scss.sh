#!/bin/bash

SRC_DIR="assets/invoiceplane/sass"
DEST_DIR="assets/invoiceplane/css"

mkdir -p $DEST_DIR

for file in $SRC_DIR/*.scss; do
  filename=$(basename "$file" .scss)
  node-sass "$file" "$DEST_DIR/$filename.css"
done
