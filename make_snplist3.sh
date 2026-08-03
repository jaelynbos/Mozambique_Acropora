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

zcat /scratch/jbos/joint_Acropora/beagles/Acropora_unlinked.beagle.gz | cut -f1 | tail -n +2 > snp_list_joint.txt
awk -F'_' '{print $1"_"$2 "\t" $3}' snp_list_joint.txt > sites_joint.txt
angsd sites index sites_joint.txt