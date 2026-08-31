#!/bin/bash
# Link against osquery wrapper static library
# Usage: ./link.sh <output> <main.o> [extra libs...]

SDK_DIR="$(cd "$(dirname "$0")" && pwd)"
WRAPPER="$SDK_DIR/../libosquery_wrapper_static.a"
THIRD_PARTY="$SDK_DIR/lib"

# Collect all third-party libraries
LIBS=$(find "$THIRD_PARTY" -name "*.a" -type f | sort)

# Link with --whole-archive to handle dependency ordering
gcc -o "$1" "$2" \
  -Wl,--whole-archive "$WRAPPER" $LIBS -Wl,--no-whole-archive \
  -lpthread -ldl -lm -lresolv -lrt \
  "${@:3}"
