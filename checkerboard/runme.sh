#!/bin/bash

set -e
rm output -rf
rm .*.{fmla,slice} -rf
mkdir output

./scmp-TEMPLATE.sh
./maurer-TEMPLATE.sh
./chamfer-TEMPLATE.sh
