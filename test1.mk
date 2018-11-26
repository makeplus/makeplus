include $(shell ../bin/make+)

# rule: ${+!file-empty(?Makefile,?x)&do-it|do-not}
# 	@figlet rule done

maybe: ${+50-50&do-it|do-not}

do-it:
	@figlet doing it

do-not:
	@figlet not doing it
