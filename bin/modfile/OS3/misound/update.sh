WORK_DIR=$(pwd)
MAIN_FOLDER="$WORK_DIR/build/baserom/images"
rom_os=$(cat $WORK_DIR/bin/ddevice/rom_os.txt)
androidVER=$(cat $WORK_DIR/bin/ddevice/androidver.txt)

MiSoundDIR=$(find "$MAIN_FOLDER" -type d -name "MiSound")


if [[ $rom_os == "OS3" ]];then
    mods "Add Sound By Bose"
    rm -rf $MiSoundDIR/*.apk
    cp -rf $WORK_DIR/bin/modfile/OS3/misound/MiSound.apk $MiSoundDIR
    mods "Add Sound by Bose Done"
fi
