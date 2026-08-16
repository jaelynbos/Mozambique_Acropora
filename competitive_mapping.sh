#!/bin/bash

#SBATCH --job-name=competitive_mapping
#SBATCH -o bwa_competitive-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=180G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --time=24:00:00

module load samtools
module load bwa-mem2

INDIR=/scratch/jbos/repaired_adiv
OUTDIR=/scratch/jbos/competitive_mapping
REF=/scratch/jbos/references/ref_concat.fna

all_samples=($INDIR/*_fp2_r1.fq.gz)
r1=${all_samples[$SLURM_ARRAY_TASK_ID]}

sample=$(basename "$r1" _fp2_r1.fq.gz)
r2=${INDIR}/${sample}_fp2_r2.fq.gz

rg_string="@RG\tID:${sample}.1\tSM:${sample}\tPL:illumina\tLB:1\tPU:1"

bwa-mem2 mem \
    -t "$SLURM_CPUS_PER_TASK" \
    -R "$rg_string" \
    "$REF" \
    "$r1" "$r2" \
    | samtools sort -@ "$SLURM_CPUS_PER_TASK" -o "${OUTDIR}/${sample}.sorted.bam" -