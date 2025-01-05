#!/bin/bash

#pyver='3.10.12'
pyver='3.12.2'

f_setup(){
    pyenv versions
    pyenv local ${pyver}
    python3 -m venv ~/venv/py${pyver}
    pip3 install pyxel==2.2.10
    pyenv local system
}

f_init(){
    pver=${1}
    mkdir -p dest
    rm -rf dest/${pver}
    cp -r org dest/${pver}
}

f_compile(){
    pver=${1}
    source ~/venv/py${pyver}/bin/activate
    find . | grep ~$ | xargs rm
    cd dest
    pyxel package ${pver} ${pver}/app.py
    cd ..
}

f_play(){
    pver=${1}
    source ~/venv/py${pyver}/bin/activate
    pyxel play dest/${pver}.pyxapp
}

f_edit(){
    pver=${1}
    source ~/venv/py${pyver}/bin/activate
    pyxel edit dest/${pver}/app.pyxres
}

f_reset(){
    pyenv local system
    find . | grep ~$ | xargs rm
    rm -rf dest
    tree
}

if [ ${#} -lt 1 ]; then
    echo 'USAGE: ./command.sh (setup / init / edit / play / reset) [version]'
    echo 'SAMPLE: ./command.sh init v1'
    exit
elif [ ${#} -eq 1 ]; then
    pver='v1'
elif [ ${#} -eq 2 ]; then
    pver=${2}
fi
    
if [ ${1} = 'setup' ]; then
    f_install
elif [ ${1} = 'init' ]; then
    f_init ${pver}
elif [ ${1} = 'edit' ]; then
    f_edit ${pver}
elif [ ${1} = 'play' ]; then
    f_compile ${pver}
    f_play ${pver}
elif [ ${1} = 'reset' ]; then
    f_reset
fi
