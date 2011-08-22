DATE=$(shell DATE)
BOOTSTRAP = ./bootstrap-1.0.0.css
BOOTSTRAP_MIN = ./bootstrap-1.0.0.min.css
BOOTSTRAP_LESS = ./lib/bootstrap.scss
LESS_COMPESSOR ?= `which sass`
WATCHR ?= `which watchr`

build:
	@@if test ! -z ${LESS_COMPESSOR}; then \
		sed 's/@DATE/'"${DATE}"'/' ${BOOTSTRAP_LESS} >${BOOTSTRAP_LESS}.tmp; \
		sass --scss ${BOOTSTRAP_LESS}.tmp:${BOOTSTRAP}; \
		sass --scss --style compressed ${BOOTSTRAP_LESS}.tmp:${BOOTSTRAP_MIN}; \
		rm -f ${BOOTSTRAP_LESS}.tmp; \
		echo "Bootstrap successfully built! - `date`"; \
	else \
		echo "You must have the SCSS compiler installed in order to build Bootstrap."; \
		echo "You can install it by running: gem install sass"; \
	fi

watch:
	@@if test ! -z ${WATCHR}; then \
	  echo "Watching scss files..."; \
	  sass --watch lib:lib; \
	else \
		echo "You must have the sass installed in order to watch Bootstrap scss files."; \
		echo "You can install it by running: gem install sass"; \
	fi

.PHONY: build watch