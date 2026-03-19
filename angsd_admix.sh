#!/bin/bash

#SBATCH --job-name=angsd_admix
#SBATCH -o angsd_admix-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load pcangsd

#pcangsd -b /scratch/jbos/Moz_intermediates/beagle_contigs/Acorpora_moz_all.beagle.gz --admix --maf 0.001 --threads 16 --it 1000 --out /scratch/jbos/Moz_intermediates/beagle_contigs/angsd_acropora_admix

pcangsd -b /scratch/jbos/Moz_intermediates/beagle_contigs_spp1/Acorpora_moz_all.beagle.gz --admix --maf 0.001 --threads 16 --it 1000 --out /scratch/jbos/Moz_intermediates/beagle_contigs_spp1/angsd_acropora_admix