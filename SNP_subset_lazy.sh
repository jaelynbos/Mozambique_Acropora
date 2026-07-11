#!/bin/bash

#SBATCH --job-name=SNP_subset
#SBATCH --output /home/jbos/Moz_scripts/SNP_subset-%j.out
#SBATCH --error /home/jbos/Moz_scripts/SNP_subset-%j.err
#SBATCH --cpus-per-task=8
#SBATCH --time=72:00:00
#SBATCH --mem=64G 
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --mail-type=ALL

module load samtools
module load ohpc
module load angsd/0.940

DIR=/scratch/jbos/Moz_aligned_mil/angsd1_output
zcat $DIR/Acropora_moz_all.beagle.gz| awk 'NR==1 || NR%1000==0' | gzip > $DIR/Acropora_moz_subset.beagle.gz