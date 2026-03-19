#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=72:00:00

module load samtools

for file in /scratch/jbos/Moz_intermediates/amuricata_bamfiles/*.sorted.bam

do
    sample=$(basename "$file" | cut -d. -f1)
    samtools index --threads=8 "$file"
    samtools coverage "$file" > /scratch/jbos/Moz_intermediates/amuricata_bamfiles/${sample}.coverage
done