#!/bin/bash

FQPATTERN="*_fp2_r1.fq.gz"
INDIR=/scratch/jbos/Moz_intermediates/repaired
OUTDIR=/scratch/jbos/Moz_intermediates/amuricata_samfiles
REF=/home/jbos/ncbi/amuricata_ncbi.fna
SCRIPT=/home/jbos/Moz_scripts/bwa_amuricata.sh
NODES=4

mkdir -p $OUTDIR

module load ohpc 
module load bwa-mem2

all_samples=($INDIR/$FQPATTERN)
n=$((${#all_samples[@]} - 1))
echo "Submitting array job with indices 0-${n}"

sbatch \
  --job-name=bwamem \
  --array=0-${n}%${NODES} \
  $SCRIPT