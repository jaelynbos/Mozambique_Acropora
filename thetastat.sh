#!/bin/bash

#SBATCH --job-name=thetastat
#SBATCH -o thetastat-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=72:00:00

module load angsd/0.940


DIR1=/scratch/jbos/Moz_aligned_mil/DB_safs_allSNPs
DIR2=/scratch/jbos/Moz_aligned_mil/DA_safs_allSNPs
DIR3=/scratch/jbos/Moz_aligned_mil/DA_south_safs_allSNPs
DIR4=/scratch/jbos/Moz_aligned_mil/DA_north_safs_allSNPs

cd $DIR1
thetaStat do_stat thetas.thetas.idx -win 5000 -step 1000

cd $DIR2
thetaStat do_stat thetas.thetas.idx -win 5000 -step 1000

cd $DIR3
thetaStat do_stat thetas.thetas.idx -win 5000 -step 1000

cd $DIR4
thetaStat do_stat thetas.thetas.idx -win 5000 -step 1000


cd $DIR1
thetaStat do_stat thetas.thetas.idx -win 1000 -step 200 -outnames finer

cd $DIR2
thetaStat do_stat thetas.thetas.idx -win 1000 -step 200 -outnames finer

cd $DIR3
thetaStat do_stat thetas.thetas.idx -win 1000 -step 200 -outnames finer

cd $DIR4
thetaStat do_stat thetas.thetas.idx -win 1000 -step 200 -outnames finer