include $(shell make+)

50-50 = return $((RANDOM % 2))

say-something: $(+50-50?say-hello|say-goodbye)

say-hello say-goodbye:
	@printf "%s, my friend!\n" `sed 's/.*/\u&/' <<< ${@:say-%=%}`
