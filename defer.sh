#! /bin/bash


test -n "$TMP" || TMP="$TEMPDIR"
test -n "$TMP" || TMP="$TEMP"
test -n "$TMP" || TMP=/tmp

time="$1"
endf="$2"
startf="$3"

id="`shasum <<< "$0 $@" | awk '{print $1}'`"
tf="$TMP/defer-$id.tmp"

if test -e "$tf"; then
  echo "1" > "$tf"
else
  sh <<< "$startf"

  echo "1" > "$tf"
  {
    while test -n "`cat "$tf"`"; do
      echo "" > "$tf"
      sleep "$time"
    done

    sh <<< "$endf"
    rm "$tf"
  } &
fi
