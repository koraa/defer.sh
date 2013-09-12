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

## EXAMPLES

TODO!

## IMPLEMENTATION

TODO!

## VERION

defer.sh version 0.0.1 from 09/12/2013.

## AUTHOR

defer.sh has been written by Karolin Varner <karo@cupdev.net>.

## REPORTING BUGS

TODO!

## TODO

TODO! (haha)

## COPYING

TODO!
