#!/bin/bash

for RESOLUTION in 512 1024 2048 4096
do for RADIUS in 5 10 15 20
do radix=scmp-$RESOLUTION-r$RADIUS
filename=$radix.topochecker
cat > $filename <<EOF 
Model "med:x=checkerboard-$RESOLUTION.nii";

Let similar5(a,b) = SCMP (x,a,$RADIUS,>0.7,-0.1,256,4) (x,b);

Let black = [ x == 0];

Let white = [ x == 255 ];

Output "output/topochecker-scmp-$RESOLUTION-r$RADIUS.nii";

Check "6" similar5(TT,TT);
EOF
echo running $filename
rm .*.{fmla,slice} -rf
/usr/bin/time -v /home/vincenzo/data/local/repos/topochecker/src/topochecker $filename 2>&1 >& output/topochecker-$radix.log
done 
done
