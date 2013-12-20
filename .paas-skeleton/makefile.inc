check-paas-skeleton-env: $(PROJECT_HOME_DIR)/etc/project-environment.sh $(PROJECT_HOME_DIR)/etc/environment.d/*
ifndef PROJECT_HOME_DIR
	$(error PROJECT_HOME_DIR environment variable is undefined, did you source env.sh?)
endif
ifndef PAAS_SKELETON_WORK_DIR
	$(error PAAS_SKELETON_WORK_DIR environment variable is undefined, did you source env.sh?)
endif

${PAAS_SKELETON_WORK_DIR}:
	mkdir -p ${PAAS_SKELETON_WORK_DIR}

.PHONY: clean-build
clean-build:
        if [[ "x$(PROJECT_HOME_DIR)x" != "xx" ]]; then rm -rf $(PROJECT_HOME_DIR)/build; fi
