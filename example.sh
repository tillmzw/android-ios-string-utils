#!/bin/bash
# tool used is:
# https://github.com/tillmzw/android-ios-string-utils

ANDROID_RES="/path/to/android/src/main/res"
IOS_BASE="/path/to/ios/myStromer"
TOOL="./strings_xml_to_localizable.py"


function magic {
# check for source (file) & destination (folder) and if both exist, run the tool on them
        src=$1
        dest=$2
        if [ -f $src ]; then
                if [ -d $dest ]; then
                        echo -e "Running \n python $TOOL $src $dest/Localizable.strings"
                        python $TOOL $src $dest/Localizable.strings
                else
                        echo "destination $dest doesn't exist"
                fi
        else
                echo "source $src doesn't exist"
        fi
}


# Android doesn't have a suffix for english localizations
magic "$ANDROID_RES/values/strings.xml" "$IOS_BASE/en.lproj"

# Do some magic for these languages
for lang in de it nl fr
do
        f="$ANDROID_RES/values-$lang/strings.xml"
        t="$IOS_BASE/$lang.lproj"
        magic $f $t
done

