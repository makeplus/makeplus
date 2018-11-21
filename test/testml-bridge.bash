#! bash

TestMLBridge.make-out() (
  set -f

  makefile=$(mktemp)
  echo "$1" > "$makefile"

  IFS=" " read -r -a args <<< "${2#make}"

  stderr=$(mktemp)

  $MAKE -f "$makefile" \
    --no-print-directory \
    "${args[@]}" \
    2>"$stderr"

  sed 's/^/# /' < "$stderr" >&2

  rm "$makefile" "$stderr"
)

TestMLBridge.run() (
  set -f

  IFS=" " read -r -a cmd <<< "$*"

  "${cmd[@]}"
)
