#!/usr/bin/env bash
# Test script for HelloWorld.java
# Scoring:
# 5 - Runs exactly as specified
# 4 - Runs but not all criteria met
# 3 - Does not run but code shows intended logic
# 2 - Runs incorrectly
# 1 - No real progress

set -euo pipefail

# ===== Compiler Block =====
compile_java() {
  if [ ! -f "HelloWorld.java" ]; then
    echo "HelloWorld.java not found."
    echo "Score: 1"
    exit 1
  fi

  echo "Compiling HelloWorld.java..."
  if ! javac HelloWorld.java 2> compile_errors.txt; then
    echo "Compilation failed:"
    cat compile_errors.txt
    echo "Score: 3"
    exit 1
  fi
  echo "Compilation successful."
}
# ==========================

run_and_score() {
  # Run and capture output (suppress JVM stderr to keep output clean)
  output="$(java HelloWorld 2> runtime_errors.txt || true)"

  # Exact match required: case-sensitive, includes '!'
  if [ "$output" = "Hello World!" ]; then
    echo "Output correct."
    echo "Score: 5"
    return
  fi

  # Partial/incorrect cases
  if [ -n "$output" ]; then
    echo "Output incorrect: '$output'"
    echo "Score: 2"
  else
    # Program ran (no crash) but produced no output
    echo "Program ran but produced no output."
    echo "Score: 4"
  fi
}

compile_java
run_and_score
