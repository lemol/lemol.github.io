SRC_DIR = src
SITE_APP = dist/build/site/site

.PHONY: all clean compile build

all: clean compile build 

clean: 
	cd $(SRC_DIR) && ../$(SITE_APP) clean

compile: $(SITE_APP)

$(SITE_APP):
	cabal build

build: $(SITE_APP)
	cd $(SRC_DIR) && ../$(SITE_APP) build

deploy:
	git commit -a
	git checkout master
	cp -r site/* .
	rm -r -f site
	git commit -a
	git push origin master
	git push origin dev

