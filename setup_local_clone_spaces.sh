#!/bin/bash

# Set up config so that tabs auto-convert to spaces on commit

ATTRIBUTES_FILE=".git/info/attributes"
if [ ! -f $ATTRIBUTES_FILE  ]; then
  echo "*.8o  filter=tabspace" > $ATTRIBUTES_FILE
fi

# Note: tab width == 2
git config --local filter.tabspace.smudge 'unexpand --tabs=2 --first-only'
git config --local filter.tabspace.smudge 'expand --tabs=2 --initial'
