#!/bin/bash
set -eu

fibonacci() {
    if [ "$1" -le 0 ]; then
        echo 0
    elif [ "$1" -eq 1 ]; then
        echo 1
    else
        echo $(($(fibonacci $(($1-2))) + $(fibonacci $(($1 - 1))) ))
    fi
}

fibonacci "$1"
