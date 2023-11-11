#!/bin/bash

# Set the path to your Ruby program
RUBY_PROGRAM="test.rb"

# Set the path to your input file
INPUT_FILE="./input.txt"

# Check if the Ruby program file exists
if [ ! -f "$RUBY_PROGRAM" ]; then
    echo "Ruby program not found: $RUBY_PROGRAM"
    exit 1
fi

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Input file not found: $INPUT_FILE"
    exit 1
fi

# Run the Ruby program with input from the file
ruby "$RUBY_PROGRAM" < "$INPUT_FILE"
