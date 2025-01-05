#!/bin/bash

ver='3.12.2' # 3.10.12
pj='platformer'

f_setup(){
    pyenv versions
    pyenv local ${ver}
    python3 -m venv ~/venv/py${ver}
    pip3 install pyxel==2.2.10
    pyenv local system
}

f_edit(){
    source ~/venv/py${ver}/bin/activate
    pyxel edit ${pj}/app.pyxres
}

f_clean(){
    pyenv local system
    find . | grep ~$ | xargs rm
    rm -f ${pj}.pyxapp
    rm -rf ${pj}/${pj}
    tree
}

f_compile(){
    source ~/venv/py${ver}/bin/activate
    rm -f ${pj}/*~
    mkdir -p ${pj}/${pj}
    cp ${pj}/app.pyxres ${pj}/${pj}/
    pyxel package ${pj} ${pj}/app.py
}

f_play(){
    source ~/venv/py${ver}/bin/activate
    pyxel play ${pj}.pyxapp
}

if [ ${#} -eq '1' ]; then
    if [ ${1} = 'setup' ]; then
        f_install
    elif [ ${1} = 'edit' ]; then
        f_edit
    elif [ ${1} = 'clean' ]; then
        f_clean
    elif [ ${1} = 'compile' ]; then
        f_compile
    elif [ ${1} = 'play' ]; then
        f_compile
        f_play
    fi
else
    echo 'USAGE: ./command.sh [setup / edit / clean / compile / play]'
fi
