# env.sh - owned by paas-skeleton.git
#
# do not modify this file outsite paas-skeleton.git
# see etc/environment.sh for more details
#
if [[ "x${OPENSHIFT_REPO_DIR}x" != "xx" ]]; then
    PROJECT_HOME_DIR=${OPENSHIFT_REPO_DIR}
else
    PROJECT_HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export PROJECT_HOME_DIR

if [[ $1 == "--auto-agree" ]]; then
    AUTO_AGREE="true"
else
    AUTO_AGREE="false"
fi

set --

source ${PROJECT_HOME_DIR}/.paas-skeleton/environment.sh

source ${PROJECT_HOME_DIR}/etc/prepare-gpg.sh
