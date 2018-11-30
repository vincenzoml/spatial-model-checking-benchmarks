#!/bin/bash

for RESOLUTION in 512 1024 2048 #4096
do for RADIUS in 10
do radix=chamfer-$RESOLUTION-r$RADIUS
filename=$radix.topochecker
cat > $filename <<EOF 
Model "med:x=checkerboard-$RESOLUTION.nii";

Let black = [ x == 0];
Let white = [ x == 255 ];

Output "output/topochecker-$radix.nii";

Check "6" EDT(black,<10);
EOF
echo running $filename
rm .*.{fmla,slice} -rf
/usr/bin/time -v /home/vincenzo/data/local/repos/topochecker/src/topochecker $filename 2>&1 >& output/topochecker-$radix.log
done 
done
