#!/bin/bash

out_path="$1"
configs="$2"

pushd paper/
    mv build-config.sty .build-config.sty.bak
    printf "$configs" > build-config.sty
    latexmk -c
    rm -f main.pdf main.abstract.output
    latexmk main
    latex_result=$?
    mv .build-config.sty.bak build-config.sty
popd

cp paper/main.pdf "$out_path"
exit $latex_result