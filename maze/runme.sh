#!/bin/bash

set -e
rm output -rf
rm .*.{fmla,slice} -rf
mkdir output

for RESOLUTION in 512 1024 2048 4096
do radix=maze-$RESOLUTION
filename=$radix.topochecker
cat > $filename <<EOF 
Model "med:r=$radix-red.nii,g=$radix-green.nii,b=$radix-blue.nii";

Let reach(a,b) = !( (!b) S (!a) );
Let touch(a,b) = a & reach(a|b,b);

Let isRed = [ r == 255.0 ] & [g==0.0] & [b==0.0];
Let isGreen = [r==0.0] & [g==255.0] & [b==0.0];
Let isBlack = [r==0.0] & [g==0.0] & [b==0.0];
Let isWhite = [r==255.0] & [g==255.0] & [b==255.0];

Let wall = isBlack;
Let path = isWhite;
Let exit = isGreen;
Let object = isRed;

Let canExit = touch(path,object) & touch(path,exit);
Let toExit = touch(path,exit) & (!touch(path,object));
Let blockedObject = touch(path,object) & (!touch(path,exit));

Output "output/topochecker-$radix-out.nii";

Check "2" canExit;
Check "3" toExit;
Check "4" blockedObject;
EOF
echo running $filename
rm .*.{fmla,slice} -rf
/usr/bin/time -v /home/vincenzo/data/local/repos/topochecker/src/topochecker $filename 2>&1 >& output/topochecker-$radix.log
done 

