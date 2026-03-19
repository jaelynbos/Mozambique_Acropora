#!/bin/bash

#SBATCH --job-name=bwamem
#SBATCH -o bwa_cladocopium-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=24:00:00

module load ohpc 
module load bwa-mem2

INDIR=/scratch/jbos/Moz_intermediates/repaired/
OUTDIR=/scratch/jbos/Moz_intermediates/cladocopium_samfiles/
REF=/home/jbos/ncbi/cladocopium_ncbi.fna

all_samples=($INDIR/*_fp2_r1.fq.gz)
r1=${all_samples[$SLURM_ARRAY_TASK_ID]}

sample=$(basename "$r1" _fp2_r1.fq.gz)
r2=${INDIR}/${sample}_fp2_r2.fq.gz

rg_string="@RG\tID:${sample}.1\tSM:${sample}\tPL:illumina\tLB:1\tPU:1"

bwa-mem2 mem \
    -t $SLURM_CPUS_PER_TASK \
    -R "$rg_string" \
    "$REF" \
    "$r1" "$r2" \
    > "${OUTDIR}/${sample}.sam"