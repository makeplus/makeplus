.SECONDEXPANSION:

# Define whitespace variables
v := \e
$v :=# empty variable
v := \s
$v := $(\e) # <- space definition
v := \t
$v := $(\e)     # <- tab definition
define \n # <- newline


endef

bin := $(PWD)/.make/bin

file-not-empty = shell $(bin)/file-not-empty $(1)

# vim: set ft=make:
