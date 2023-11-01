#!/bin/bash

set -e

lint_sort_wordlist(){
  LC_COLLATE=C sort -u < .wordlist-md > tmp
  mv tmp .wordlist-md
}

lint_sort_wordlist
