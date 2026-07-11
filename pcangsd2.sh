#!/bin/bash

#SBATCH --job-name=pcangsd
#SBATCH -o pcangsd-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=286G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load pcangsd

DIR=/scratch/jbos/Moz_aligned_mil/angsd_output137

pcangsd -b $DIR/Acropora_moz_unlinked.beagle.gz  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_acropora_pca2

pcangsd -b $DIR/Acropora_moz_unlinked.beagle.gz  --admix  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_acropora_admix2
