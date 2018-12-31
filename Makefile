.PHONY: epub clean

EPUB = json-schema.epub

all: $(EPUB)

$(EPUB): json-schema-spec
	cd json-schema-spec; git pull
	$(MAKE) -C json-schema-spec clean all 
	mkdir -p epub/EPUB epub/META-INF
	echo "application/epub+zip" > epub/mimetype
	cp container.xml epub/META-INF/
	cp package.opf epub/EPUB/
	cp json-schema-spec/*.html epub/EPUB/
	cp toc.html cover.html epub/EPUB/
	cd epub; zip -0 -X ../$(EPUB) mimetype; zip -r ../json-schema.epub . -x mimetype

json-schema-spec:
	git clone https://github.com/json-schema-org/json-schema-spec.git

clean:
	rm -rf epub
	rm -f $(EPUB)

