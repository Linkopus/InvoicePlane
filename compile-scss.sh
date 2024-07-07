#!/bin/bash

SRC_INVOICEPLANE_DIR="assets/invoiceplane/sass"
DEST_INVOICEPLANE_DIR="assets/invoiceplane/css"

mkdir -p $DEST_DIR

for file in $SRC_INVOICEPLANE_DIR/*.scss; do
  filename=$(basename "$file" .scss)
  node-sass "$file" "$DEST_INVOICEPLANE_DIR/$filename.css"
done

SRC_INVOICEPLANE_BLEU_DIR="assets/invoiceplane_blue/sass"
DEST_INVOICEPLANE_BLEU_DIR="assets/invoiceplane_blue/css"

mkdir -p $DEST_DIR

for file in $SRC_INVOICEPLANE_BLEU_DIR/*.scss; do
  filename=$(basename "$file" .scss)
  node-sass "$file" "$DEST_INVOICEPLANE_BLEU_DIR/$filename.css"
done