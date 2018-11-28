include $(shell make+)

happy ?= 17
hour := $(shell perl -e 'print((localtime)[2])')
is-it = [[ $1 -eq $2 ]]
early-for = [[ $2 -lt $1 ]]

me-happy?: ${+is-it(%happy,%hour)?yes|no}

yes: ; $(say) "IT'S HAPPY HOUR!!! :-)"

no: ${+early-for(%happy,%hour)?too-early|too-late}

too-%: ; $(say) "You're $(subst -, ,$@) for happy hour :-("

say :=  @clear; echo; figlet -c -W -w$(shell tput cols)

${+require-command(figlet)}
