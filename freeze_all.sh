#!/usr/bin/env bash

while read file
do
    echo " >> Freezing file: $file..."
    dhall freeze --all $file
    dhall format $file
done < './files-to-freeze.txt'
