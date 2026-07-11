#!/bin/bash

#SBATCH --job-name=make_sites
#SBATCH --output /home/jbos/Moz_scripts/SNPlist-%j.out
#SBATCH --error /home/jbos/Moz_scripts/SNPlist-%j.err
#SBATCH --cpus-per-task=8
#SBATCH --time=1:00:00
#SBATCH --mem=8G 
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --mail-type=ALL

module load angsd/0.940

zcat /scratch/jbos/Moz_aligned_mil/angsd1_output/Acropora_moz_subset.beagle.gz | cut -f1 | tail -n +2 > snp_list1.txt
awk -F'_' '{print $1"_"$2 "\t" $3}' snp_list1.txt > sites1.txt
angsd sites index sites1.txt

