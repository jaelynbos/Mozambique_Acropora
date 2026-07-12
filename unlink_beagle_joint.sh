#!/bin/bash

#SBATCH --job-name=beagle_unlink
#SBATCH --output beagle_unlink-%j.out
#SBATCH --error beagle_unlink-%j.err
#SBATCH --cpus-per-task=2
#SBATCH --time=12:00:00
#SBATCH --mem=8G 
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --mail-type=ALL

module load angsd/0.940

DIR=/scratch/jbos/joint_Acropora/beagles

zcat $DIR/Acropora_all.beagle.gz | awk 'NR==FNR {gsub(/:/, "_"); keep[$1]=1; next} FNR==1 {print; next} keep[$1]' $DIR/LD_pruned/Acropora_unlinked.pos - | gzip > $DIR/Acropora_unlinked.beagle.gz 