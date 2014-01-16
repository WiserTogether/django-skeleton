.PHONY: docs
docs: build/docs.html build/specification.html

build/docs.html: docs/00index.adoc docs/* docs/*/* .paas-skeleton/asciidoc/*
	asciidoctor -o $@ docs/00index.adoc

build/specification.html: docs/specification.adoc .paas-skeleton/asciidoc/*
	asciidoctor -o $@ docs/specification.adoc

docs/specification.adoc:
	if [ ! -e docs/specification.adoc ]; then cp -v .paas-skeleton/asciidoc/specification.adoc docs/specification.adoc; fi

%.svg: %.gv
	dot -Tsvg $< > $@
