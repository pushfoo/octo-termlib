#!/bin/bash
HAVE_CHIPLET=$(which chiplet)
if ! [ -f "$HAVE_CHIPLET" ]; then
  echo "Couldn't find chiplet! Please install from https://github.com/gulrak/chiplet"
  exit
fi
cd src || exit
mkdir -p ../build
OUTPUT_PATH="build/termlib_demo.8o"
chiplet --no-line-info -o "../$OUTPUT_PATH" -P demo_main.8o

cd ..
if [ -f "build/termlib_demo.8o" ]; then
  echo "Success! Built demo at $OUTPUT_PATH"
fi
