MakePlus
========

**MakePlus** is a simple software package that adds great new capabilities
to the ubiquitous **GNU `make`** tool. GNU `make` can be found on almost all
modern computer systems. MakePlus has very minimal prerequisites and can even
be added as a single file to your project.

By adding one **include** line to the start of your `Makefile`, you get:

* **Functional Prerequisite Testing** (instead of just file timestamps)
  * Use testing functions from the **MakePlus Standard Library**
  * Use any testing program in your **PATH** that returns 0 or 1(-255)
  * Define **inline testing functions** in your Makefile
* **Special Commands** to do common things
* **Special Targets** for MakePlus related tasks
* MakePlus features integrate nicely with the standard make features
  * Use Makefile variables in your prerequisite testing functions
  * Automatic variables (like `$<`) can use output from testing functions

## Example Makefile using MakePlus

Here's a Makefile that prints a Hello or Goodbye greeting.

``` make
include $(shell make+)

50-50 = return $((RANDOM % 2))

say-something: $(+50-50?say-hello|say-goodbye)

say-hello say-goodbye:
	@printf "%s, my friend!\n" `sed 's/.*/\u&/' <<< ${@:say-%=%}`
```

[Install MakePlus](https://github.com/makeplus/makeplus/blob/master/ReadMe.md#makeplus-installation),
save the above text into a file called `Makefile` and run `make say-something`.

If you don't want to install MakePlus yet, change the first line to:
```
include $(shell wget -qnc https://makeplus.net/.make+;. ./.make+)
```
and the first time you run `make` it will auto-install MakePlus locally in your
current directory.

### How it Works

The first line triggers all the MakePlus magic! The rest of the Makefile is a
normal GNU Makfile, except for things that begin with a `+`.

Note the 'say-something' rule. It has a prerequisite that calls a test function
(`50-50` defined inline) and invokes one of two different rules depending on the
result.

## Try It Now

MakePlus comes with a bunch of demo Makefiles that are easy to run. Try out the
[red-fish-blue-fish](https://www.mfwi.edu/MFWI/Recordings/One%20Fish.pdf) demo
now!

Copy this command and paste it into a terminal:
```
(
  set -e
  cd $(mktemp -d)
  wget -q https://makeplus.net/red-fish-blue-fish/Makefile
  while true; do
    clear
    (set -x; make fish)
    echo press enter
    read
  done
)
```

Every time you press enter it will run `make fish` which should display 1 or 2
red or blue fish. The Makefile is
[here](https://github.com/makeplus/makeplus/blob/master/demo/red-fish-blue-fish/Makefile).
See if you can figure it out. (It's not hard. :)

## More MakePlus Info

* [Source Code](https://github.com/makeplus/makeplus)
* [Installation](https://github.com/makeplus/makeplus/blob/master/ReadMe.md#makeplus-installation)
* [Documentation](https://github.com/makeplus/makeplus/blob/master/ReadMe.md#makeplus)
* [Demos](https://github.com/makeplus/makeplus/tree/master/demo)
* [Issues](https://github.com/makeplus/makeplus/issues)
* Chat in #makeplus on irc.freenode.net
