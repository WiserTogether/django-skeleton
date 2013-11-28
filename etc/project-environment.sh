# put your project-specific environment customizations here
#
# load in "helpers" from the etc/paas-skeleton/ folder by adding lines such as:
# source ${PROJECT_HOME_DIR}/etc/paas-skeleton/python/virtualenv.sh

# become a python project
source ${PROJECT_HOME_DIR}/.paas-skeleton/python/virtualenv.sh

# change this to match your project
PROJECT_NAME=skeleton

if [[ "${OPENSHIFT_POSTGRESQL_DB_URL}xx" != "xx" ]]; then
    export DATABASE_URL=$OPENSHIFT_POSTGRESQL_DB_URL/$PGDATABASE
    export DJANGO_SETTINGS_MODULE="${PROJECT_NAME}.settings"
else
    export DJANGO_SETTINGS_MODULE="${PROJECT_NAME}.test_settings"
    export DATABASE_URL="postgres://localhost/${PROJECT_NAME}_test"
fi

if [[ "${OPENSHIFT_PATTON_IP}xx" == "xx" ]]; then
    export OPENSHIFT_PATTON_IP="127.0.0.1"
    export OPENSHIFT_PATTON_PORT="50009"
fi

export ES_CLASSPATH="$VE_ROOT/share/elasticsearch/lib/*"
if [[ "${ELASTICSEARCH_SERVER_URL}xx" != "xx" ]]; then
    export ELASTICSEARCH_SERVER_URL="$ELASTICSEARCH_SERVER_URL"
else
    export ELASTICSEARCH_SERVER_URL="http://localhost:50015"
fi

export PYTHONPATH=${PROJECT_HOME_DIR}
