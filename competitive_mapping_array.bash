#!/bin/bash

FQPATTERN="*_fp2_r1.fq.gz"

INDIR=/scratch/jbos/repaired_adiv
OUTDIR=/scratch/jbos/competitive_mapping/
REF=/scratch/jbos/references/ref_concat.fna
NODES=4

module load bwa-mem2

all_samples=($INDIR/$FQPATTERN)
n=$((${#all_samples[@]} - 1))
echo "Submitting array job with indices 0-${n}"

sbatch \
  --job-name=bwamem \
  --array=0-${n}%${NODES} \
  competitive_mapping.sh