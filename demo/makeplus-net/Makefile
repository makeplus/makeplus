include $(shell make+)

weekday := $(shell perl -e 'print((localtime)[6])')
sunday = [[ $1 -eq 0 ]]

greeting: ${+!sunday(%weekday)?message|resting}

message: ; @echo 'Hello, world!'

resting: ; @echo "Sorry I'm resting today."

$(+require-command perl)
