#! bash

TestMLBridge.make-out() (
  run-command "$@"

  echo "$stdout"

  sed 's/^/# /' < "$stderr" >&2

  rm "$makefile" "$stderr"
)

TestMLBridge.make-err() (
  run-command "$@"

  cat "$stderr"

  rm "$makefile" "$stderr"
)

TestMLBridge.run() (
  set -f

  IFS=" " read -r -a cmd <<< "$*"

  "${cmd[@]}"
)

run-command() {
  set -f

  makefile=$(mktemp)
  echo "$1" > "$makefile"

  IFS=" " read -r -a args <<< "${2#make}"

  stderr=$(mktemp)

  stdout=$(
    $MAKE -f "$makefile" \
      --no-print-directory \
      "${args[@]}" \
      2>"$stderr" | grep -v 'Nothing to be done for'
  )
}
