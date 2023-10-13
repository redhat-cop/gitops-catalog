#!/bin/bash

set -e

TEMP_WORDLIST=.temp-wordlist-md
WORDLIST=.wordlist-md

if [ -e ${TEMP_WORDLIST} ] ; then
    rm ${TEMP_WORDLIST}
fi
LC_COLLATE=C sort -u < .wordlist-md > ${TEMP_WORDLIST}

if [ -e ${WORDLIST} ] ; then
    rm ${WORDLIST}
fi

mv ${TEMP_WORDLIST} ${WORDLIST}
