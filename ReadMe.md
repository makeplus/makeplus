MakePlus
========

***GNU Make in Overdrive***

# Synopsis

Your Makefile:
```
include $(shell make+)

maybe = return $((RANDOM % 2))

rule: $(+maybe?yes|no)

yes no:
	@echo $@ | tr a-z A-Z
```

Running `make` will randomly print `YES` or `NO`.

# Description

GNU `make` is an amazing automation tool. It exists or is trivially available
on almost all computer systems. It has been around for decades and has tons of
useful features.

The major drawback is that actions are only triggered by file modication,
instead of user defined functions/conditions. For this reason, people
continually reinvent Make, but the new solutions always have problems of their
own.

MakePlus is a set of extensions that build on top of GNU make. It provides you
with a set of ready-to-use condition testing functions, and allows you to
easily write your own. Everything from your old Makefile still works, but now
you have a lot more power, with little effort.

MakePlus can be used with any existing GNU Makefile. All you need to do is add
this line at the top of your Makefile:
```
include $(shell make+)
```

Now you have a new world of Makefile capability available to use.

# MakePlus Usage

When you add the `include $(shell make+)` line to the start of your Makefile,
MakePlus silently scans your Makefile(s), generates an additional makefile
(usually as a temp file) and includes it. The result is that you now have new
powerful features added to your normal GNU make capabilites.

Consider this Makefile:
```
include $(shell make+)

${+require-command(echo)}

maybe = $((RANDOM % 2))

rule: $(+maybe?yes|no)

yes no:
	@echo $@ | tr a-z A-Z
```

All MakePlus additions begin with a `+` character.

The `${+require-command(echo)}` line is a simple way for a Makefile to declare
its dependency on a system command (in this case `echo`). See "MakePlus Special
Commands" below.

The primary capability to use MakePlus for is function based dependency
checking. The rule prerequisite `$(+maybe?yes|no)` says call the `maybe`
function and if true, depend on the `yes` rule, else depend on the `no` rule.

Dependency functions can either be in your PATH or defined as Makefile
variables that contain shell code. The functions check something and return 0
(true) for success or 1 (false) for failure.

Note: Normally these functions do not print any output, but they are allowed to
print words to stdout that become the dependency rules to be invoked. They may
also print a failure message to stdout or warnings to stderr. MakePlus captures
the stdout and figures out what to do with it based on the calling context.

# MakePlus Prerequisite Syntax

The syntax for a MakePlus rule prerequisite is:
```
rule: `$` (`(`|`{`) `+` `!`?  <check-name> (`(` <arg-list> `)`)? \
      (`?` <then-rule>)? (`|` <else-rule>)? `!`? (`}`|`)`)
```

If that is too complicated to digest right now, here are some examples:
```
rule1: $(+check)                     # If check then '+check'
rule2: $(+check!)                    # check or HALT
rule3: $(+check?this)                # If check then 'this'
rule4: $(+check|that)                # check or 'that'
rule5: $(+check?this|that)           # If check then 'this' else 'that'
rule6: ${+check(42,'foo',%VAR)?this} # If check(42,'foo',$(VAR)) then 'this'
rule7: $(+!check)                    # If not check then '+!check'
rule8: $(+!check!)                   # Not check or HALT
rule9: $(+!check?this|that)          # If not check then
```

That should give you an idea of what is possible. Note that if your check
function requires arguments (in parentheses) you must use curly braces to
enclose the construct.

No whitespace is allowed in these expressions. What you are creating here are
**actual Makefile variables**! These allow any characters except whitespace,
`=`, `:` and `#`. See
<https://www.gnu.org/software/make/manual/html_node/Using-Variables.html>

If no `!` (must) `?` (then) or `|` (else) follows the check, the 'then' rule
uses the same name as the check function (including the + and ! but excluding
any arguments).

Makefile variable expansion here uses `%VAR` (instead of normal `$(VAR)`).

## Comparison to Normal Prerequisites

In a normal make prerequisite, the word has three meanings. In this rule:
```
this: that
```

The `that` prerequisite defines:

* A file name (`that`)
* A test (check if `that` is out-of-date; older than `this`)
* A 'then' rule (`that`) to run if out-of-date

Note: `make` provides no way to trigger a rule if the check fails.

We could do the same thing in longhand with MakePlus:
```
this: ${+out-of-date(that)?that}
```

Here all 3 items are specified explicitly. This allows any of them to be
changed independently of the others.

We could also trigger a rule if the file is up to date:
```
this: ${+out-of-date(that)?that|other}
```

# MakePlus Special Commands

MakePlus automatically gives you special commands that always begin with a `+`.

* `${+require-command(<cmd>[,<version>])`

  Halt Makefile processing unless the command is available. Optionally check
  the command version. For example:
  ```
  ${+require-command(git,2.5+)}
  ```

# MakePlus Special Targets

MakePlus automatically gives you special targets that always begin with a `+`.

* `make +makeplus`

  The `+makeplus` target will print out the version on MakePlus being used.
  This is a handy way to see if MakePlus is set up correctly in your Makefile.

* `make +update`

  Update a local the local MakePlus assets, if a project has localized them
  with the `makeplus --local ...` command.

# MakePlus Installation

First get the MakePlus source code from GitHub:
```
git clone https://github.com/makeplus/makeplus /path/to/makeplus
```

## System Install

Install permanently on your system. The default PREFIX is `/usr/local` which
usually requires using `sudo`.
```
cd /path/to/makeplus
[sudo] make install [PREFIX=/install/path/prefix]
```

## User Install

Run this command to enable MakePlus in your current shell. Add it to your
shell's 'rc' file to make it persistent.
```
source /path/to/makeplus/.rc
```

## Local Project Install

If you want to use MakePlus in your project but not require your users or
project developers to have it installed, you can bundle it into your project.
MakePlus makes this super easy.

You will need to have MakePlus installed already, as per above. Then...

If you are already using MakePlus in your project Makefile already, just run:
```
make +local
```

If you are starting from scratch, run:
```
make+ --local
```

In either case, this will install all the parts of MakePlus you are using into
the `./.makeplus/` directory. It will change your Makefile to use the local
version. If you started from scratch without a Makefile, it will create one.

This process will scan your Makefile, and include only the elements of MakePlus
that you require. At any time after this, you can run `make +local` again to
sync your local files with the installed version, according to your current
needs.

NOTE: If you want to rename the local installation directory, all you have to
do is run `mv .makeplus <new-directory-name>` and then change your Makefile
`include` line to point to the new location. Future runs of `make +local` will
use the new location.

# Prerequisites

These basic utilities are already installed on most systems:

* GNU `make`

  Obviously!

* Bash 3.2 or higher

  You don't need to use Bash as your shell; you just need to have it installed.

* Perl 5 (any version)

  Perl is not needed if you bundle MakePlus directly into your project. See
  "Local Project Install" above.

# Development and Contribution

Nothing great is created by one person in isolation. If you like the concept of
MakePlus and have ideas about how it currently is not good enough, please
contribute!

* Share feature ideas or report bugs:

  https://github.com/makeplus/makeplus/issues

* Chat with MakePlus developers:

  `#makeplus` on irc.freenode.net

## Debugging

MakePlus generates a temporary Makefile that you never see. To see it, set
`MAKEPLUS_MAKEFILE` environment variable to a file path. If the file does not
exist, MakePlus will put the generated file there. If it does exist already,
MakePlus will use it. That way you can actually modify it to figure things out.

Use GNU make's special variables to print Makefile processing info:

* `$(info ...)`
* `$(warning ...)`
* `$(error ...)`

## Testing

To run the MakePlus test suite, clone the source repository per above, and run
`make test` from the top level directory.

The tests are all written in TestML. The Makefile fetches TestML automatically
for you. See <https://github.com/testml-lang/testml>.

# Status

This is a very early version of the MakePlus software. It seems to be working
out fantastically well so far, but I expect the unexpected. :)

Some of the ancillary features like "Local Project Install", `makeplus
--local`, `make +update` (in the docs above) are not yet implemented, but
will be very soon. All the important things are really working. See the `test`
suite if you are curious.

# Change Log

* **v0.0.2 - Nov 29 2018**

  * Made the http://makeplus.net website
  * Implement the special commands processing
  * Implement "must" (+test-cond!) stopping on fail
  * Add Development and Contribution section to doc
  * Get automatic make variables working with MakePlus prereqs
  * Add Travis CI testing
  * Got docker-server demo working properly
  * Add a happy-hour demo
  * Improve all demos
  * `MAKEPLUS_PATH` is variable of directories to find test functions
  * Fix a couple test fails with OSX output
  * Add ability to test failure conditions

* **v0.0.1 - Nov 24 2018**

  First release. Test suite is passing on my laptop. Demos (in the `demo`
  directory seem to work).

  Features include:
  * Functional Prerequisites
    * Function Assertion (must or halt)
    * System (PATH) and Inline testing functions
    * Function argument support, with variable expansion
    * Function Negation
    * Then and Else rule invocation, with variable expansion
  * Special Commands
  * Special Targets
  * Simple Installation
    * System-wide
    * Per user
    * Per shell
    * Per project

  Demos include (in `demo` directory):
  * synopsis - The example Makefile in at the top of this doc.
  * red-fish-blue-fish - Well defined fishy randomness!
  * docker-server - Start / Stop / Build a docker server.

# Current Issues

GNU make resolves all rule prerequisites up front. This means that all MakePlus
checking functions will be run up front, even if you are only interested in a
specific rule. This can lead to slower than expected run times if the functions
are costly. I'm looking for an elegant way to defer the execution until it is
actually required. Suggestions welcome!

# Author

Ingy döt Net <ingy@ingy.net>

# License and Copyright

The MIT License (MIT)

Copyright (c) 2018 Ingy döt Net
