#!/bin/bash
set -u

execignoreends=/"ignoreBamReadEnds.py"
python $execignoreends \
            -5p 1 -3p 1 \
            /sorted_RG_unique.bam \
            /sorted_RG_unique_endsIGN.bam
