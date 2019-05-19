include $(shell make+)

today = $(shell perl -e 'print((localtime)[6])')

is-sunday = [ $1 -eq 0 ]

greeting: ${+!is-sunday(%today)?message|resting}

message: ; @echo 'Hello, world!'

resting: ; @echo "Sorry I'm resting today."
