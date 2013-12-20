# etc/environment.sh
#
# configure the universal environment settings for this container.
# any environment options necessary to properly interact with a supported
# PAAS container should be handled here.
#
# this file will automatically load in "project-environment.sh" and "local-environment.sh"
# to load per-project and per-environment configurations. You should not need to modify
# this file itself
#

# bail out if we don't know our home directory
if [[ "x${PROJECT_HOME_DIR}x" == "xx" ]]; then
    echo "PROJECT_HOME_DIR is not set, exiting"
    exit 1
fi

# figure out a good location for our working environment
if [[ "x${VIRTUAL_ENV}x" != "xx" ]]; then
    # a python virtualenv is active, use it
    PAAS_SKELETON_WORK_DIR=${VIRTUAL_ENV}

elif [[ "x${OPENSHIFT_DATA_DIR}x" != "xx" ]]; then
    # we are on openshift, use the data dir
    PAAS_SKELETON_WORK_DIR=${OPENSHIFT_DATA_DIR}
else
    # otherwise, work out of a directory
    PAAS_SKELETON_WORK_DIR=${HOME}/.paas_skeleton/`basename ${PWD}`
fi
export PAAS_SKELETON_WORK_DIR

if [ ! -d ${PAAS_SKELETON_WORK_DIR} ]; then
    echo "Creating skeleton work dir ${PAAS_SKELETON_WORK_DIR}"
    mkdir -p ${PAAS_SKELETON_WORK_DIR}
fi

# Set the Postgres LD_LIBRARY_PATH if it isn't already set
PG_LD_PATH=$(LD_LIBRARY_PATH="" scl enable postgresql92 "printenv LD_LIBRARY_PATH")
if [[ "xx${LD_LIBRARY_PATH/$PG_LD_PATH//}" == "xx${LD_LIBRARY_PATH}" ]]; then
     export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PG_LD_PATH; 
fi

# bring in local configurations from environment.d/*.sh
if [ -d "${PROJECT_HOME_DIR}/etc/environment.d/" ]; then
    for i in ${PROJECT_HOME_DIR}/etc/environment.d/*.sh; do
      if [ -r "$i" ]; then
        . $i
      fi
    done
    unset i
fi

# bring in per-project configurations
if [ -f "${PROJECT_HOME_DIR}/etc/project-environment.sh" ]; then
    source ${PROJECT_HOME_DIR}/etc/project-environment.sh
fi

