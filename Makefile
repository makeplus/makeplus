NAME := makeplus
PREFIX ?= /usr/local
INSTALL_BIN ?= $(PREFIX)/bin
INSTALL_LIB ?= $(PREFIX)/lib
INSTALL_LIB := $(INSTALL_LIB)/$(NAME)
INSTALL_SHARE ?= $(PREFIX)/share
INSTALL_SHARE := $(INSTALL_SHARE)/$(NAME)

TESTML_ROOT := .testml
TESTML_REPO := https://github.com/testml-lang/testml

PATH := $(TESTML_ROOT)/bin:$(PATH)

export PATH TESTML_ROOT MAKE

test := test/*.tml

#------------------------------------------------------------------------------
default:

.PHONY: test
test: $(TESTML_ROOT)
	prove -v $(test)

install:
	install -d $(INSTALL_BIN)
	install bin/* $(INSTALL_BIN)
	install -d $(INSTALL_LIB)
	install lib/$(NAME)/* $(INSTALL_LIB)
	install -d $(INSTALL_SHARE)
	install share/$(NAME)/* $(INSTALL_SHARE)

check:
	shellcheck .rc
	shellcheck bin/make+
	shellcheck bin/makeplus
	shellcheck lib/makeplus/env
	shellcheck lib/makeplus/makeplus-check
	perl -c lib/makeplus/makeplus-generate
	shellcheck lib/makeplus/require-command
	make --no-print-directory -n
	@#make --no-print-directory -f share/makeplus/makeplus.mk -n

gh-pages note talk:
	git worktree add -f $@ $@

clean:
	rm -fr test/.testml

realclean: clean
	rm -fr .testml gh-pages note talk

#------------------------------------------------------------------------------
$(TESTML_ROOT):
	git clone --depth=1 --quiet $(TESTML_REPO) $@
	(cd $@ && git fetch origin ext/perl:ext/perl && make ext/perl)
