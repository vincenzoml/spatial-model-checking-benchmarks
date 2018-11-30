#!/bin/bash

echo "filename,CPU time,memory (kb)" > global-output.csv

for file in $(find . -iname "*.log"); do
    echo -n $(basename $file .log), >> global-output.csv
    grep "Maximum resident set size\|User time" $file|cut -f 2 -d ":"|tr "\n" ","|sed 's@,$@\n@' >> global-output.csv
done