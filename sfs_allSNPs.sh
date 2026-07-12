#!/bin/bash

#SBATCH --job-name=sfs
#SBATCH -o sfs-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=400G
#SBATCH --time=72:00:00

module load samtools
module load ohpc
module load angsd/0.940

DIR1=/scratch/jbos/Moz_aligned_mil/DB_safs_allSNPs
DIR2=/scratch/jbos/Moz_aligned_mil/DA_safs_allSNPs
DIR3=/scratch/jbos/Moz_aligned_mil/DA_south_safs_allSNPs
DIR4=/scratch/jbos/Moz_aligned_mil/DA_north_safs_allSNPs

realSFS cat $DIR1/Acropora_moz.NC*saf.idx -outnames $DIR1/DB_all
realSFS cat $DIR2/Acropora_moz.NC*saf.idx -outnames $DIR2/DA_all
realSFS cat $DIR3/Acropora_moz.NC*saf.idx -outnames $DIR3/DA_south_all
realSFS cat $DIR4/Acropora_moz.NC*saf.idx -outnames $DIR4/DA_north_all

realSFS $DIR1/DB_all.saf.idx -P 8 -fold 1 > $DIR1/DB_all.sfs
realSFS $DIR2/DA_all.saf.idx -P 8 -fold 1 > $DIR2/DA_all.sfs
realSFS $DIR3/DA_south_all.saf.idx -P 8 -fold 1 > $DIR3/DA_south_all.sfs
realSFS $DIR4/DA_north_all.saf.idx -P 8 -fold 1 > $DIR4/DA_north_all.sfs
