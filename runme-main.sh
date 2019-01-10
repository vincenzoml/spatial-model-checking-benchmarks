#!/bin/sh

for f in $(find . -name runme.sh); do
    echo running $f
    (cd $(dirname $f) && ./$(basename $f))
done

