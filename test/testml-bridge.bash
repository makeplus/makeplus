#! bash

TestMLBridge.make-out() (
  base=$1
  make=${2-}
  rule=${3:-test}

  run-command "$base" "$make" "$rule"

  echo "$stdout"

  sed 's/^/# /' < "$stderr" >&2

  rm "$makefile" "$stderr"
)

TestMLBridge.make-err() (
  base=$1
  make=${2-}
  rule=test

  run-command "$base" "$make" "$rule"

  cat "$stderr"

  rm "$makefile" "$stderr"
)

TestMLBridge.make-rule() (
  make=$1
  rule=$2

  TestMLBridge.make-out '' "$make" "$rule"
)

TestMLBridge.run() (
  set -f

  IFS=" " read -r -a rule <<< "$*"

  "${rule[@]}"
)

run-command() {
  set -f

  makefile=$(mktemp)
  (
    echo "$1"
    echo
    echo "${2-}"
  ) > "$makefile"

  stderr=$(mktemp)

  stdout=$(
    $MAKE -f "$makefile" \
      --no-print-directory \
      $rule \
      2>"$stderr" | grep -v 'Nothing to be done for'
  )
}
