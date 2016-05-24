#!/bin/bash

# Clean Lines
cat $1 | cut -d'#' -f1 | grep .