#!/bin/bash
#
#SBATCH --job-name=bamsort
#SBATCH -o bamsort-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=96G
#SBATCH --time=72:00:00

module load samtools 

mkdir /scratch/jbos/Moz_intermediates/amuricata_bam_sorted/

for file in $(ls -v /scratch/jbos/Moz_intermediates/amuricata_bamfiles/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools sort /scratch/jbos/Moz_intermediates/amuricata_bamfiles/$sample.bam -o /scratch/jbos/Moz_intermediates/amuricata_bam_sorted/$sample.bam
done

