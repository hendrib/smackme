#!/bin/bash

VSN=`cat ../../apps/smackme/src/smackme.app.src | grep vsn | grep -Eo '["].+["]' | sed 's|"||g'`

cp smackme.template smackme

sed -s "s|%VSN%|${VSN}|g" -i smackme

equivs-build smackme

#EOF
