#!/bin/bash
# tool used is:
# https://github.com/tillmzw/android-ios-string-utils

# This script assumes the default languages to be EN!

# DEFINE TARGET LANGUAGES NEAR END OF SCRIPT

if [ ! $ANDROID_RES ]; then
	echo "Please supply the path to the android res folder via the environment variable ANDROID_RES"
	echo "e.g.: ANDROID_RES=\"\$HOME/code/repos/android/src/main/res\" $0"
	exit 1
fi

if [ ! $IOS_BASE ]; then
	echo "Please supply the root path where the <lang>.lproj folders are located via environment variable IOS_BASE"
	echo "e.g.: IOS_BASE=\"\$HOME/code/repos/iosproject\" ANDROID_RES=\"$ANDROID_RES\" $0"
	exit 1
fi

#http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TOOL="$DIR/strings_xml_to_localizable.py"

function android_to_ios {
	src=$1
	dest=$2
        if [ -f $src ]; then
                if [ -d $dest ]; then
                        echo -e "Running \n python $TOOL $src $dest/Localizable.strings" 
                        python $TOOL $src $dest/Localizable.strings
                        if [ $? -gt 0 ]; then
                            echo "Previous command encountered an error. Exiting."
                            exit 3
                        fi
                else
                        echo "destination $dest doesn't exist"
                        exit 2
                fi
        else
                echo "source $src doesn't exist"
                exit 2
        fi
}


android_to_ios "$ANDROID_RES/values/strings.xml" "$IOS_BASE/en.lproj"

# DEFINE LANGUAGES HERE
for lang in de it nl fr
do
    f="$ANDROID_RES/values-$lang/strings.xml"
    t="$IOS_BASE/$lang.lproj"
    android_to_ios $f $t
done
