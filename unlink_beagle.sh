#!/bin/bash

#SBATCH --job-name=beagle_unlink
#SBATCH --output beagle_unlink-%j.out
#SBATCH --error beagle_unlink-%j.err
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00
#SBATCH --mem=8G 
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --mail-type=ALL

module load angsd/0.940

DIR=/scratch/jbos/Moz_aligned_mil/angsd_output137

zcat $DIR/Acropora_moz_all.beagle.gz | awk 'NR==FNR {gsub(/:/, "_"); keep[$1]=1; next} FNR==1 {print; next} keep[$1]' $DIR/LD_pruned/Acropora_moz_unlinked.pos - | gzip > $DIR/Acropora_moz_unlinked.beagle.gz 

zcat $DIR/Acropora_moz_unlinked.beagle.gz | cut -f1 | tail -n +2 > snp_list2.txt
awk -F'_' '{print $1"_"$2 "\t" $3}' snp_list2.txt > sites2.txt
angsd sites index sites2.txt
