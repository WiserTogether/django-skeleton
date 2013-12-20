# .paas-skeleton/python/virtualenv-makefile.inc
# TODO: make this complain if VIRTUAL_ENV isn't set
PYTHON_BIN := $(VIRTUAL_ENV)/bin/python
#VE_FLAGS := --extra-search-dir $(PWD)/lib/buildout-cache/dist --never-download --use-distribute var/ve; fi
#PIP_FlAGS := --quiet install --no-index --find-links file://$(PWD)/lib/buildout-cache/dist 
VE_FLAGS := --use-distribute 
PIP_FlAGS := 

.PHONY: check-python-virtualenv
check-python-virtualenv: $(PYTHON_BIN)

$(PROJECT_HOME_DIR)/requirements.txt:
	echo "honcho" >> $@

.PHONY: touch-requirements
touch-requirements:
	touch $(PROJECT_HOME_DIR)/requirements.txt

.PHONY: force-update-virtualenv
force-update-virtualenv: touch-requirements $(VIRTUAL_ENV)/lib/python2.7/site-packages

$(VIRTUAL_ENV)/lib/python2.7/site-packages: $(PROJECT_HOME_DIR)/.paas-skeleton/python/virtualenv-makefile.inc $(PROJECT_HOME_DIR)/requirements.txt
	if [ ! -f $(PYTHON_BIN) ]; then python2.7 $(PROJECT_HOME_DIR)/.paas-skeleton/python/virtualenv.py $(VE_FLAGS) $(VIRTUAL_ENV); fi
	$(VIRTUAL_ENV)/bin/easy_install readline
	$(VIRTUAL_ENV)/bin/pip install $(PIP_FLAGS) -r requirements.txt
	touch $(VIRTUAL_ENV)/lib/python2.7/site-packages

$(VIRTUAL_ENV)/bin/activate: $(VIRTUAL_ENV)/lib/python2.7/site-packages

.PHONY: clean-python-virtualenv
clean-python-virtualenv:
	if [[ "x$(VIRTUAL_ENV)x" != "xx" ]]; then rm -rf $(VIRTUAL_ENV); fi


$(PYTHON_BIN): $(VIRTUAL_ENV)/lib/python2.7/site-packages
