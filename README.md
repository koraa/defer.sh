# Defer.sh

## NAME

defer - Delay the execution of a programm with signals

## INVOKE

defer timeout script

## DESCRIPTIION

On the first call, a defer creates a fork
that runs the script after the _timeout_.

Each successive call to defer delays the execution of the _script_.

Please note, that these calls are not delaying the invocation by
a specific duration. Think  of it more like of a keepalive:
If _defer_  has not been called since _timeout_, the _script_ will
be executed.

Also note, that each defer is identified by all its argumeents
(more precise: "$0 $@").
This means, that each ooof the following calls  are completely individual:

```bash
defer 0.1 "echo a" "echo b"
defer 0.2 "echo a" "echo b"
defer 0.2 "echo  a" "echo b"
```

## EXAMPLES

My motivation for writing this, was to display mmmy tmux status bar
only when holding  down a key, so I added this to my config::

```bash
bind -nr ^ run-shell -b "defer 0.15 'tmux set -g status off'  'tmux set -g status on' 2>/dev/null >/dev/null"
```

This means: While circumflex is pressed invoke the comand given in regular
intervals.

## VERION

defer.sh version 0.0.1 from 09/12/2013.

## AUTHOR

defer.sh has been written by Karolin Varner <karo@cupdev.net>.

## REPORTING BUGS

You can file bug reports and feature requests on github:

https://github.com/koraa/defer.sh/pulls

## TODO

* Options: nofork, tmpdir, signature, tmpfile, hashf
* Accumulate mode
* Timeout mode (force delay between invocations)
* Signal sources: SIGUSR1, fifo, pipe
* On-defer-block
* On-start-block
* Expire file
* Query
* Version info in script
* Support --help/-h (inject manpage?)
* Silent mode  for commands

## COPYING

Copyright © 2013 Free Software Foundation, Inc. License GPLv3+: 
GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
