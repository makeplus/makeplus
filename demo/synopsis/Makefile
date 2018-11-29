include $(shell bin/make+)

maybe = return $((RANDOM % 2))

rule: $(+maybe?yes|no)

yes no:
	@echo $@ | tr a-z A-Z
