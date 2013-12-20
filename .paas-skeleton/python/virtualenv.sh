# .paas-skeleton/python-virtualenv.sh - owned by paas-skeleton.git

# pick up the currently active virtual environment, if defined
if [[ "x${VIRTUAL_ENV}x" != "xx" ]]; then
    VE_ROOT=${VIRTUAL_ENV}
else
    VE_ROOT=${PAAS_SKELETON_WORK_DIR}
    export VIRTUAL_ENV=${PAAS_SKELETON_WORK_DIR}
fi

# create the virtual environment only if it does not already exist
make check-paas-skeleton-env $VE_ROOT/bin/activate

# activate the virtual environment
source $VE_ROOT/bin/activate
