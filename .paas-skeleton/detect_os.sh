# partially borrowed from here https://github.com/coto/server-easy-install/blob/master/lib/core.sh

lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}


PAAS_SKELETON_PLATFORM=`lowercase \`uname\``


if [[ "${PAAS_SKELETON_PLATFORM}" == "windowsnt" ]]; then
        PAAS_SKELETON_PLATFORM=windows
elif [[ "${PAAS_SKELETON_PLATFORM}" == "darwin" ]]; then
        PAAS_SKELETON_PLATFORM=mac
else
        PAAS_SKELETON_PLATFORM=`uname`
        if [[ "${PAAS_SKELETON_PLATFORM}" = "Sun" ]]; then
                PAAS_SKELETON_PLATFORM=Solaris
                ARCH=`uname -p`
                PAAS_SKELETON_DISTRO="${PAAS_SKELETON_PLATFORM} ${DISTRO_REV}(${ARCH} `uname -v`)"
        elif [[ "${PAAS_SKELETON_PLATFORM}" = "AIX" ]] ; then
                PAAS_SKELETON_DISTRO="${PAAS_SKELETON_PLATFORM} `oslevel` (`oslevel -r`)"
        elif [[ "${PAAS_SKELETON_PLATFORM}" = "Linux" ]] ; then
                if [ -f /etc/redhat-release ] ; then
                        DISTRO_BASE='RedHat'
                        DISTRO=`cat /etc/redhat-release |sed s/\ release.*//`
                        DISTRO_PSEUDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
                        DISTRO_REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
                elif [ -f /etc/SuSE-release ] ; then
                        DISTRO_BASE='SuSe'
                        DISTRO_PSEUDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
                        DISTRO_REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
                elif [ -f /etc/mandrake-release ] ; then
                        DISTRO_BASE='Mandrake'
                        DISTRO_PSEUDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
                        DISTRO_REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
                elif [ -f /etc/debian_version ] ; then
                        DISTRO_BASE='Debian'
                        if [ -f /etc/lsb-release ] ; then
                                DISTRO=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
                                DISTRO_PSEUDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
                                DISTRO_REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
                        elif [ -f /etc/lsb-release-crunchbang ] ; then
                                DISTRO='debian'
                                DISTRO_REV=$(printf %.0f `cat /etc/debian_version`);
                        fi
                fi
                if [ -f /etc/UnitedLinux-release ] ; then
                        DISTRO="${DISTRO}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
                fi
                PAAS_SKELETON_PLATFORM=`lowercase $PAAS_SKELETON_PLATFORM`
                PAAS_SKELETON_DISTRO="${DISTRO}_${DISTRO_REV}"
                PAAS_SKELETON_DISTRO=`lowercase $PAAS_SKELETON_DISTRO`
        fi

fi

export PAAS_SKELETON_PLATFORM
export PAAS_SKELETON_DISTRO
