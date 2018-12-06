MakePlus
========

**MakePlus** is a simple software package that adds great new capabilities
to the ubiquitous **GNU `make`** tool. GNU `make` can be found on almost all
modern computer systems. MakePlus has very minimal prerequisites and can even
be added as a single file to your project.

By adding one **include** line to the start of your `Makefile`, you get:

* **Functional Prerequisite Testing** (instead of just file timestamps)
  * Use testing functions from the **MakePlus Standard Library**
  * Use any testing program in your **PATH** that returns 0 or 1
  * Define **inline testing functions** in your Makefile
* **Special Commands** to do common things
* **Special Targets** for MakePlus related tasks
* MakePlus features integrate nicely with the standard make features
  * Use Makefile variables in your prerequisite testing functions
  * Automatic variables (like `$<`) can use output from testing functions

## Example Makefile using MakePlus

Here's a Makefile that prints a greeting to the world, except on Sunday:

``` make
include $(shell make+)

today = $(shell perl -e 'print((localtime)[6])')

is-sunday = [ $1 -eq 0 ]

greeting: ${+!is-sunday(%today)?message|resting}

message: ; @echo 'Hello, world!'

resting: ; @echo "Sorry I'm resting today."
```

Run `make greeting`.

The first line triggers all the MakePlus magic! The rest of the Makefile is a
normal GNU Makfile, except for things that begin with a `+`.

Note the 'greeting' rule. It has a prerequisite that calls a test function
(defined inline) passing it an argument (from a variable) and calls one of two
different rules depending on the result. The `!` in front of `sunday` reverses
the decision. In other words, test that today is *not* Sunday.

## Try It Now

MakePlus comes with a bunch of demo Makefiles that are easy to run. Try out the
[red-fish-blue-fish](https://www.mfwi.edu/MFWI/Recordings/One%20Fish.pdf) demo
now!

Copy this command and run it in a terminal:
```
(git clone https://github.com/makeplus/makeplus; source makeplus/.rc && cd makeplus/demo/red-fish-blue-fish && while true; do (set -x; make fish); echo press enter; read; done)
```

Every time you press enter it will run `make fish` which should display 1 or 2
red or blue fish. The Makefile is
[here](https://github.com/makeplus/makeplus/blob/master/demo/red-fish-blue-fish/Makefile).
See if you figure it out. (It's not hard. :)

## More MakePlus Info

* [Source Code](https://github.com/makeplus/makeplus)
* [Installation](https://github.com/makeplus/makeplus/blob/master/ReadMe.md#makeplus-installation)
* [Documentation](https://github.com/makeplus/makeplus/blob/master/ReadMe.md#makeplus)
* [Demos](https://github.com/makeplus/makeplus/tree/master/demo)
* [Issues](https://github.com/makeplus/makeplus/issues)
* Chat in #makeplus on irc.freenode.net
