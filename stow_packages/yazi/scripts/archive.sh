#!/bin/sh
format="$1"
shift

target="$(basename "$1").$format"
n=$#
for f; do
  set -- "$@" "${f#"$PWD/"}"
done
shift "$n"

case "$format" in
tar.gz) tar -czf "$target" "$@" ;;
zip) zip -r "$target" "$@" ;;
esac
