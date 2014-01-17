#!/bin/bash
# check_dpkg_installed.sh:

source ${PROJECT_HOME_DIR}/etc/systems_packages.sh
source ${PROJECT_HOME_DIR}/.paas-skeleton/command_run_confirmation.sh

install_apt_packages(){
    for package_name in $1
    do
        echo "Installing ${package_name}..."

        # PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $package_name|grep "install ok installed")

        # if [ "" == "$PKG_OK" ]; then
        #     sudo apt-get --force-yes --yes install $package_name
        # else
        #     echo "${package_name} already installed!"
        # fi
        run_with_confirmation "sudo apt-get --force-yes --yes install $package_name"

    done
}

install_brew_packages(){
    for package_name in $1
    do
        echo "Installing ${package_name}..."
        run_with_confirmation "sudo brew install $package_name"
    done
}

if [[ "$PAAS_SKELETON_PLATFORM" == "mac" ]]; then
        install_brew_packages "${PACKAGES_MAC_OS}"

elif [[ "$PAAS_SKELETON_PLATFORM" == "linux" ]]; then
    if [[ "$PAAS_SKELETON_DISTRO" == "ubuntu_12.04" ]]; then
        install_apt_packages "${PACKAGES_UBUNTU_12_04}"
    elif [[ "$PAAS_SKELETON_DISTRO" == "ubuntu_13.10" ]]; then
        install_apt_packages "${PACKAGES_UBUNTU_13_10}"
    elif [[ "$PAAS_SKELETON_DISTRO" == "debian_7" ]]; then
        install_apt_packages "${PACKAGES_DEBIAN_7}"
    else
        echo "No packages for ${PAAS_SKELETON_DISTRO} should be installed"
    fi
fi