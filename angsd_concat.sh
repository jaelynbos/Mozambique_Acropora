#!/bin/bash

#SBATCH --job-name=angsd_concat
#SBATCH -o angsd_out/angsd_concat-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=24:00:00

module load samtools

OUTDIR=/scratch/jbos/Moz_intermediates/beagle_contigs_spp1_strict

first=1
for f in ${OUTDIR}/Acropora_moz.*.beagle.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR}/Acropora_moz_all.beagle.gz


first=1
for f in ${OUTDIR}/Acropora_moz.*.mafs.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR}/Acropora_moz_all.mafs.gz