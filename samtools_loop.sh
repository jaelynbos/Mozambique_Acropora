#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=20
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=200:00:00

module load samtools 

for file in $(ls -v /scratch/jbos/Moz_intermediates/amuricata_samfiles/*.sam | head -n +30)
do
    sample=$(basename "$file" | cut -d. -f1)
    samtools view --threads 20 -b -F 2308 /scratch/jbos/Moz_intermediates/amuricata_samfiles/$sample.sam \
    | samtools sort --threads 20 -o /scratch/jbos/Moz_intermediates/amuricata_bamfiles/$sample.sorted.bam
done