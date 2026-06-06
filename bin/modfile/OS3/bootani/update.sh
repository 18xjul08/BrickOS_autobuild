WORK_DIR=$(pwd)
codename=$(cat $WORK_DIR/bin/ddevice/device_code.txt)


BootAniDIR=$WORK_DIR/build/baserom/images/product/media


if [[ $codename == "dada" || $codename == "haotian" || $codename == "xuanyuan" || $codename == "houji" || $codename == "shennong" || $codename == "aurora" || $codename == "fuxi" || $codename == "nuwa" || $codename == "ishtar" ]];then
    rm -rf $BootAniDIR/bootanimation.zip
    cp -rf $WORK_DIR/bin/modfile/OS3/bootani/bootanimation.zip $BootAniDIR
    mods "Added LEICA bootanimation Done"
fi