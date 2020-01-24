#1/bin/bash

function st(){
    wget "https://dl.suckless.org/st/st-0.8.2.tar.gz"  
    tar -xvf  "st-0.8.2.tar.gz"
    cd "st-0.8.2"
    wget "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff"
    patch < st-alpha-0.8.2.diff
    make
    sudo make install
    cd ../
    rm  st-0.8.2.tar.gz
    rm -rf st-0.8.2
}

st

