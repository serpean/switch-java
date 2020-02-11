#!/bin/bash

# Unpack your jdk on /usr/lib/jvm/<jdk>
# Probably you should execute as root

J_INFO_NAME=$1
PRIORITY=$2

JDK_HOME="/usr/lib/jvm/$J_INFO_NAME"
J_INFO_FILE="$JDK_HOME/$J_INFO_NAME.jinfo"
ALTERNATIVE_SH_FILE="$JDK_HOME/alternative.sh"
SWITCH_SCRIPT="$JDK_HOME/$J_INFO_NAME.sh"

get_bienaries () {
    ls -1 $1
}

get_jre_binaries() {
    get_bienaries "$JDK_HOME/jre/bin"
}

get_jdk_binaries () {
    get_bienaries "$JDK_HOME/bin"
}

if [ $# != 2 ]; then
    echo "Illegal number of parameters"
    exit 2
fi

if [ ! -d $JDK_HOME ]; then
  echo "JDK_HOME not found in $JDK_HOME"
  exit 2
fi

if [ -f $J_INFO_FILE ]; then
   echo "File $J_INFO_FILE exists. Removing..."
   rm $J_INFO_FILE
fi

if [ -f $ALTERNATIVE_SH_FILE ]; then
   echo "File $ALTERNATIVE_SH_FILE exists. Removing..."
   rm $ALTERNATIVE_SH_FILE
fi

echo > $ALTERNATIVE_SH_FILE
echo "Crated file on $ALTERNATIVE_SH_FILE"

echo "Created file on $J_INFO_FILE"
echo "alias=$J_INFO_NAME" > $J_INFO_FILE
echo "section=non-free" >> $J_INFO_FILE

get_jdk_binaries | while read line;
do
    echo "jdk $line $JDK_HOME/bin/$line" >> $J_INFO_FILE
    echo "update-alternatives --install /usr/bin/$line $line $JDK_HOME/bin/$line $PRIORITY" >> $ALTERNATIVE_SH_FILE
done

if [ -d "$JDK_HOME/jre/" ] && [[ $J_INFO_NAME =~ .*-[1-8]-.* ]]; then
  echo "JDK <= 8 and JRE found in $JDK_HOME/jre"
  get_jre_binaries | while read line;
    do
        echo "jre $line $JDK_HOME/jre/bin/$line" >> $J_INFO_FILE
        echo "update-alternatives --install /usr/bin/$line $line $JDK_HOME/jre/bin/$line $PRIORITY" >> $ALTERNATIVE_SH_FILE
    done
else
    echo "JRE dir doesn't exist anymore after java 9"
fi

cp $J_INFO_FILE /usr/lib/jvm/
rm $J_INFO_FILE

bash $ALTERNATIVE_SH_FILE
echo "Generating switch script on $SWITCH_SCRIPT..."
echo "update-java-alternatives -s $J_INFO_NAME" > $SWITCH_SCRIPT
echo "export JAVA_HOME=/usr/lib/jvm/$J_INFO_NAME/" >> $SWITCH_SCRIPT
echo "export PATH=\$PATH:\$JAVA_HOME" >> $SWITCH_SCRIPT