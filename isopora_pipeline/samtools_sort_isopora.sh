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

DIR=/scratch/jbos/isopora/amillepora_samfiles
FILE=ERR16728350.sam

# Convert SAM to sorted BAM and index it
samtools view -bS $DIR/$FILE \
    | samtools sort -o $DIR/isopora.bam

samtools index $DIR/isopora.bam
