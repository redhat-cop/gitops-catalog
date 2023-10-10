#!/bin/bash

set -e

TEMP_WORDLIST=.temp-wordlist-md
WORDLIST=.wordlist-md

if [ -e ${TEMP_WORDLIST} ] ; then
    rm ${TEMP_WORDLIST}
fi
cat .wordlist-md | LC_COLLATE=C sort -u > ${TEMP_WORDLIST}

if [ -e ${WORDLIST} ] ; then
    rm ${WORDLIST}
fi

mv ${TEMP_WORDLIST} ${WORDLIST}
