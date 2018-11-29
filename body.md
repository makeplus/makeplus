MakePlus
========

**MakePlus** is a new simple software package that adds great new capabilities
to the ubiquitous GNU `make` tool. GNU make can be found on almost all modern
computer systems, and MakePlus has very minimal prerequisites.

By adding one simple line to the start of you `Makefile`, you get:

* Functional prerequisite testing (instead of just file timestamps)
  * Use testing functions from MakePlus' standard library
  * Use any testing program in your PATH that returns 0 or 1
  * Define test functions inline in your Makefile
* Automatic variables (like `$<`) can use output from checking functions
* Special commands to do common things
* ALl the new features integrate nicely with the standard make features

See these links for more info:

* [Source Code](https://github.com/makeplus/makeplus)
* [Installation](https://github.com/makeplus/makeplus#makeplus-installation)
* [Documentation](https://github.com/makeplus/makeplus#makeplus)
* [Demos](https://github.com/makeplus/makeplus/tree/master/demo)
* [Issues](https://github.com/makeplus/makeplus/issues)
* Chat in #makeplus on irc.freenode.net

## Example Makefile using MakePlus

Here's a Makefile that prints a greeting to the world, except on Sunday:

``` make
include $(shell make+)

weekday := $(shell perl -e 'print((localtime)[6])')
sunday = [[ $1 -eq 0 ]]

greeting: ${+sunday(%weekday)?message|resting}

message: ; @echo 'Hello, world!'

resting: ; @echo "Sorry I'm resting today."

$(+require-command perl)
```

Run `make greeting`.

The first line triggers all the MakePlus magic! The rest of the Makefile is a
normal GNU Makfile, except for things that begin with a `+`.

Note the 'greeting' rule. It has a prerequisite that calls a test function
(defined inline) passing it an argument (from a variable) and calls one of two
different rules depending on the result.

The last line is a simple function to make sure a command (`perl` in this case)
is installed. It it isn't the Makefile will stop.
