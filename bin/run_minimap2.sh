#!/bin/bash

set -e

minimap_exec=$1
samtools_exec=$2
nb_threads=$3
fasta_t=$4
fasta_q=$5
query=$6
target=$7
paf_raw=$8
paf=$9

# Index fasta files:
${samtools_exec} faidx ${fasta_t}
${samtools_exec} faidx ${fasta_q}

# Run minimap:
${minimap_exec} -t ${nb_threads} ${fasta_t} ${fasta_q} > ${paf_raw}

# Parse paf raw file:
prepare_paf.py -i ${paf_raw} -q ${fasta_q} -t ${fasta_t} -o ${paf} -r ${query} -u ${target}

# Remove raw file:
rm -f ${paf_raw}