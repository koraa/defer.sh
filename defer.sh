#! /bin/bash

exerr() {
  echo >&2  "$2"
  exit $1
}

bool() {
  test "$1" = "true"
}

test -n "$TMP" || TMP="$TEMPDIR"
test -n "$TMP" || TMP="$TEMP"
test -n "$TMP" || TMP=/tmpA

fork=true
id=""
tf=""
hashf='shasum | awk "{print $1}"'

while getopts "nt:f:H:s:" op; do
  val="$OPTARG"
  case $op in
    n) fork=false;;
    t) TMP="$val";;
    f) tf="$val";;
    H) hashf="$val";;
    s) id="$val";;
    \?) exerr 1 "Invalid option: -$OPTARG" >&2 ;;
    :)  exerr 1 "Option -$OPTARG requires an argument." ;;
  esac
done

time="$1"
endf="$2"
startf="$3"

test -n "$tf" || {
  test  -n "$id" || 
    id="`<<< "$0 $@" $hashf`"
  tf="$TMP/defer-$id.tmp"
}

if test -e "$tf"; then
  echo "1" > "$tf"
else
  sh <<< "$startf"

  echo "1" > "$tf"
  waiter() {
    while test -n "`cat "$tf"`"; do
      echo "" > "$tf"
      sleep "$time"
    done

    sh <<< "$endf"
    rm "$tf"
  }

  if bool $fork; then  # Is there no nicer way to do this
    waiter&
  else
    waiter
  fi
fi
