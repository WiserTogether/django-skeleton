.PHONY: docs
docs: build/docs.html

build/docs.html: docs/00index.adoc docs/* docs/*/* .paas-skeleton/asciidoc/*
	asciidoctor -o $@ docs/00index.adoc

%.svg: %.gv
	dot -Tsvg $< > $@
