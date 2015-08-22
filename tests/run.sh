#!/bin/bash

SBCL=$(whereis -b sbcl | awk -F" " '{print $2}')
SCRIPT=lispvirt-run.lisp

if [ ! -z "$SBCL" -a "$SBCL" != " " ]; then
    $SBCL --script $SCRIPT --noprint
else
    echo "sbcl binaries was not found."
fi
