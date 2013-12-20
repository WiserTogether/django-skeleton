# .paas-skeleton/elasticsearch/makefile.inc
# TODO: make elasticsearch complain if PAAS_SKELETON_WORK_DIR isn't set
# TODO: allow local config to skip elasticsearch download
ELASTICSEARCH_URL := https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.tar.gz
ELASTICSEARCH_ROOT := $(PAAS_SKELETON_WORK_DIR)/share/elasticsearch

.PHONY: check-elasticsearch
check-elasticsearch: $(ELASTICSEARCH_ROOT)

$(PAAS_SKELETON_WORK_DIR)/share: $(PAAS_SKELETON_WORK_DIR)
	mkdir -p $@
	touch $@

$(ELASTICSEARCH_ROOT): $(PAAS_SKELETON_WORK_DIR)/share
	if [ ! -d $(ELASTICSEARCH_ROOT) ]; then \
	curl $(ELASTICSEARCH_URL) -so - | tar -zxvC $(PAAS_SKELETON_WORK_DIR)/share/; \
	mv $(PAAS_SKELETON_WORK_DIR)/share/elasticsearch-* $(ELASTICSEARCH_ROOT); \
	if [ ! -d $(PAAS_SKELETON_WORK_DIR)/bin ]; then mkdir $(PAAS_SKELETON_WORK_DIR)/bin; fi; \
	ln -s $(ELASTICSEARCH_ROOT)/bin/elasticsearch $(PAAS_SKELETON_WORK_DIR)/bin/elasticsearch; \
	fi
	touch $(ELASTICSEARCH_ROOT)
