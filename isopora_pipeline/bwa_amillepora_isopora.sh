#!/bin/bash

#SBATCH --job-name=bwamem
#SBATCH -o bwa_amillepora-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --time=24:00:00

module load ohpc 
module load bwa-mem2

INDIR=/scratch/jbos/isopora/repaired/
OUTDIR=/scratch/jbos/isopora/amillepora_samfiles/
REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna

mkdir $OUTDIR

all_samples=($INDIR/*.fp2_r1.fq.gz)
r1=${all_samples[$SLURM_ARRAY_TASK_ID]}

sample=$(basename "$r1" .fp2_r1.fq.gz)
r2=${INDIR}/${sample}.fp2_r2.fq.gz

rg_string="@RG\tID:${sample}.1\tSM:${sample}\tPL:illumina\tLB:1\tPU:1"

bwa-mem2 mem \
    -t $SLURM_CPUS_PER_TASK \
    -R "$rg_string" \
    "$REF" \
    "$r1" "$r2" \
    > "${OUTDIR}/${sample}.sam"