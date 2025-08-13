#!/bin/bash
# Test script for HelloWorld.java
# Scoring:
# 5 - Runs exactly as specified
# 4 - Runs but not all criteria met
# 3 - Does not run but code shows intended logic
# 2 - Runs incorrectly
# 1 - No real progress

# Compile the Java file
javac HelloWorld.java 2> compile_errors.txt
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    echo "Score: 3"
    exit 1
fi

# Run the program and capture output
output=$(java HelloWorld 2> runtime_errors.txt)

# Check exact match (case-sensitive, includes '!')
if [ "$output" == "Hello World!" ]; then
    echo "Output correct."
    echo "Score: 5"
else
    if [ -n "$output" ]; then
        echo "Output incorrect: '$output'"
        echo "Score: 2"
    else
        echo "Program ran but produced no output."
        echo "Score: 4"
    fi
fi
