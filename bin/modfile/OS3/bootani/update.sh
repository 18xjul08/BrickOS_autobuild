WORK_DIR=$(pwd)
codename=$(cat $WORK_DIR/bin/ddevice/device_code.txt)


BootAniDIR=$WORK_DIR/build/baserom/images/product/media


if [[ $codename == "DADA" || $codename == "HAOTIAN" || $codename == "XUANYUAN" || $codename == "HOUJI" || $codename == "SHENNONG" || $codename == "AURORA" || $codename == "FUXI" || $codename == "NUWA" || $codename == "ISHTAR" ]];then
    mods "Add Leica bootanimation for flagship devices"
    rm -rf $BootAniDIR/bootanimation.zip
    cp -rf $WORK_DIR/bin/modfile/OS3/bootani/bootanimation.zip $BootAniDIR
    mods "Add Leica bootanimation done"
fi
