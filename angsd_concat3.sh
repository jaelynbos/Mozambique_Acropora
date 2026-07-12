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

OUTDIR_B=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppB

first=1
for f in ${OUTDIR_B}/Acropora_moz.N*beagle.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR_B}/Acropora_moz_all.beagle.gz

first=1
for f in ${OUTDIR_B}/Acropora_moz.N*.mafs.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR_B}/Acropora_moz_all.mafs.gz


OUTDIR_A_North=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppA_north

first=1
for f in ${OUTDIR_A_North}/Acropora_moz.N*beagle.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR_A_North}/Acropora_moz_all.beagle.gz

first=1
for f in ${OUTDIR_A_North}/Acropora_moz.N*.mafs.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR_A_North}/Acropora_moz_all.mafs.gz


OUTDIR_A_south=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppA_south

first=1
for f in ${OUTDIR_A_south}/Acropora_moz.N*beagle.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR_A_south}/Acropora_moz_all.beagle.gz

first=1
for f in ${OUTDIR_A_south}/Acropora_moz.N*.mafs.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${OUTDIR_A_south}/Acropora_moz_all.mafs.gz
