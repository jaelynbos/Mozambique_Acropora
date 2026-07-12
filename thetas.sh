#!/bin/bash

#SBATCH --job-name=thetas
#SBATCH -o thetas-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

DIR1=/scratch/jbos/Moz_aligned_mil/DB_safs_allSNPs
DIR2=/scratch/jbos/Moz_aligned_mil/DA_safs_allSNPs
DIR3=/scratch/jbos/Moz_aligned_mil/DA_south_safs_allSNPs
DIR4=/scratch/jbos/Moz_aligned_mil/DA_north_safs_allSNPs

cd $DIR1
realSFS saf2theta DB_all.saf.idx -P 8 -sfs DB_all.sfs -outname thetas

cd $DIR2
realSFS saf2theta DA_all.saf.idx -P 8 -sfs DA_all.sfs -outname thetas

cd $DIR3
realSFS saf2theta DA_south_all.saf.idx -P 8 -sfs DA_south_all.sfs -outname thetas

cd $DIR4
realSFS saf2theta DA_north_all.saf.idx -P 8 -sfs DA_north_all.sfs -outname thetas