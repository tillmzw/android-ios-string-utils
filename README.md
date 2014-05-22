android-ios-string-utils
========================

Collection of scripts to cleanup Android string.xml files and convert them to iOS Localizable.strings


# Usage
    ANDROID_SRC="strings.xml"
    INTERMEDIATE="/tmp/formatted-strings.xml"
    IOS_TARGET="Localizable.strings"
    python clean_android_strings.py $ANDROID_SRC $INTERMEDIATE
    python strings_xml_to_localizable.py $INTERMEDIATE $IOS_TARGET
    
    rm $INTERMEDIATE
