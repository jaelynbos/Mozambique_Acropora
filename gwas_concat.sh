#!/bin/bash

#SBATCH --job-name=gwas_concat
#SBATCH -o angsd_out/gwas_concat-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=24:00:00

module load samtools

OUTDIR1=/scratch/jbos/Moz_aligned_mil/GWAS1

first=1
for f in ${OUTDIR1}/Acropora_gwas.N*.lrt0.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR1}/Acropora_gwas_all.lrt0.gz

OUTDIR2=/scratch/jbos/Moz_aligned_mil/GWAS_Wimbe

first=1
for f in ${OUTDIR2}/Acropora_gwas.N*.lrt0.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR2}/Acropora_gwas_all.lrt0.gz

OUTDIR3=/scratch/jbos/Moz_aligned_mil/GWAS_Bay

first=1
for f in ${OUTDIR3}/Acropora_gwas.N*.lrt0.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR3}/Acropora_gwas_all.lrt0.gz
