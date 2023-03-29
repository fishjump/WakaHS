#!/bin/bash

# remember add INPUT_WAKA_API_KEY=<YOUR_API_KEY> to env vars 
INPUT_TEMPLATE=./template.md INPUT_README=./output.md cabal run wakahs
