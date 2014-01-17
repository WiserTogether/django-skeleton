# .paas-skeleton/python/virtualenv-makefile.inc
# TODO: make this complain if VIRTUAL_ENV isn't set
PYTHON_BIN := ${VIRTUAL_ENV}/bin/python
#VE_FLAGS := --extra-search-dir $(PWD)/lib/buildout-cache/dist --never-download var/ve; fi
VE_FLAGS := --no-site-packages --extra-search-dir=${PROJECT_HOME_DIR}/.paas-skeleton/python/virtualenv_support
PIP_FLAGS := --quiet --default-timeout=400 --download-cache=${PIP_DOWNLOAD_CACHE} --use-mirrors


.PHONY: check-python-virtualenv
check-python-virtualenv: $(PYTHON_BIN)

$(PROJECT_HOME_DIR)/requirements.txt:
	echo "honcho" >> $@
	echo "supervisor" >> $@

.PHONY: touch-requirements
touch-requirements:
	touch ${PROJECT_HOME_DIR}/requirements.txt

.PHONY: force-update-virtualenv
force-update-virtualenv: touch-requirements ${VIRTUAL_ENV}/lib/python2.7/site-packages

$(VIRTUAL_ENV)/.ve_complete: $(VIRTUAL_ENV)
	touch $(VIRTUAL_ENV)/.ve_complete

$(VIRTUAL_ENV)/lib/python2.7/site-packages: $(PROJECT_HOME_DIR)/.paas-skeleton/python/virtualenv-makefile.inc $(PROJECT_HOME_DIR)/requirements.txt $(VIRTUAL_ENV)/.ve_complete
	if [ ! -f $(PYTHON_BIN) ]; then python2.7 $(PROJECT_HOME_DIR)/.paas-skeleton/python/virtualenv.py $(VE_FLAGS) $(VIRTUAL_ENV); fi
	touch $(VIRTUAL_ENV)/.ve_complete
	$(VIRTUAL_ENV)/bin/easy_install readline
	touch $(VIRTUAL_ENV)/.ve_complete
	if [ "xx" != 'x$(PIP_EXTRAS)x' ]; then for extra in $(PIP_EXTRAS); do \
	$(VIRTUAL_ENV)/bin/pip install $(PIP_FLAGS) $$extra; \
	echo "Installing $extra"; \
	touch $(VIRTUAL_ENV)/.ve_complete; \
	done; fi
	if ! $(VIRTUAL_ENV)/bin/pip install $(PIP_FLAGS) -r requirements.txt; then \
	touch $(VIRTUAL_ENV)/.ve_complete; \
	fi
	touch $(VIRTUAL_ENV)/lib/python2.7/site-packages

${VIRTUAL_ENV}/bin/activate: ${VIRTUAL_ENV}/lib/python2.7/site-packages

.PHONY: clean-python-virtualenv
clean-python-virtualenv:
	if [ "x$(VIRTUAL_ENV)x" != "xx" ]; then rm -rf $(VIRTUAL_ENV); fi

$(PYTHON_BIN): ${VIRTUAL_ENV}/lib/python2.7/site-packages
