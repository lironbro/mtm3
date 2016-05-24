#!/bin/bash

# Clean Lines

cat | grep . | cat | while read line; do
	cut -d"#" -f1
done | grep . | cat