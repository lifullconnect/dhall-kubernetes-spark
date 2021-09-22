#!/usr/bin/env bash

while read file
do
    echo " >> Unfreezing file: $file..."
    tmp_filename=".$file.tmp"
    awk '{ gsub(/sha256:[a-f0-9]{64}/, ""); print }' $file > $tmp_filename
    mv $tmp_filename $file
    dhall format $file
done < './files-to-freeze.txt'
