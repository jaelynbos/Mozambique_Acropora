#!/bin/bash

#SBATCH --job-name=fst
#SBATCH -o fst_3v10-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

## First, concat saf files
DIR1=/scratch/jbos/Moz_aligned_mil/grp1
DIR2=/scratch/jbos/Moz_aligned_mil/grp2
DIR3=/scratch/jbos/Moz_aligned_mil/grp3
DIR4=/scratch/jbos/Moz_aligned_mil/grp4
DIR5=/scratch/jbos/Moz_aligned_mil/grp5
DIR6=/scratch/jbos/Moz_aligned_mil/grp6
DIR7=/scratch/jbos/Moz_aligned_mil/grp7
DIR8=/scratch/jbos/Moz_aligned_mil/grp8

realSFS cat $DIR1/Acropora_moz.NC*saf.idx -outnames $DIR1/grp1_saf
realSFS cat $DIR2/Acropora_moz.NC*saf.idx -outnames $DIR2/grp2_saf
realSFS cat $DIR3/Acropora_moz.NC*saf.idx -outnames $DIR3/grp3_saf
realSFS cat $DIR4/Acropora_moz.NC*saf.idx -outnames $DIR4/grp4_saf
realSFS cat $DIR5/Acropora_moz.NC*saf.idx -outnames $DIR5/grp5_saf
realSFS cat $DIR6/Acropora_moz.NC*saf.idx -outnames $DIR6/grp6_saf
realSFS cat $DIR7/Acropora_moz.NC*saf.idx -outnames $DIR7/grp7_saf
realSFS cat $DIR8/Acropora_moz.NC*saf.idx -outnames $DIR8/grp8_saf


#This script generates a number of files, so creating a new directory and copying the .saf.idx files into it.
SAF1=$DIR1/grp1_saf.saf.idx
SAF2=$DIR2/grp2_saf.saf.idx
SAF3=$DIR3/grp3_saf.saf.idx
SAF4=$DIR4/grp4_saf.saf.idx
SAF5=$DIR5/grp5_saf.saf.idx
SAF6=$DIR6/grp6_saf.saf.idx
SAF7=$DIR7/grp7_saf.saf.idx
SAF8=$DIR8/grp8_saf.saf.idx

DIR=/scratch/jbos/Moz_aligned_mil/sfs
THREADS=8

cd $DIR

#GROUP 3 vs 1
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF1 -P $THREADS  > grp31.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF1  -sfs grp31.2dSFS -fstout grp31.alpha_beta
realSFS fst print grp31.alpha_beta.fst.idx > grp31.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp31.alpha_beta.txt > grp31.fst
# Estimating average Fst in angsd
realSFS fst stats grp31.alpha_beta.fst.idx > grp31.average_fst.txt

#GROUP 3 vs 2
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF2 -P $THREADS  > grp32.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF2  -sfs grp32.2dSFS -fstout grp32.alpha_beta
realSFS fst print grp32.alpha_beta.fst.idx > grp32.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp32.alpha_beta.txt > grp32.fst
# Estimating average Fst in angsd
realSFS fst stats grp32.alpha_beta.fst.idx > grp32.average_fst.txt

#GROUP 3 vs 4
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF4 -P $THREADS  > grp34.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF4  -sfs grp34.2dSFS -fstout grp34.alpha_beta
realSFS fst print grp34.alpha_beta.fst.idx > grp34.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp34.alpha_beta.txt > grp34.fst
# Estimating average Fst in angsd
realSFS fst stats grp34.alpha_beta.fst.idx > grp34.average_fst.txt

#GROUP 3 vs 5
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF5 -P $THREADS  > grp35.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF5  -sfs grp35.2dSFS -fstout grp35.alpha_beta
realSFS fst print grp35.alpha_beta.fst.idx > grp35.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp35.alpha_beta.txt > grp35.fst
# Estimating average Fst in angsd
realSFS fst stats grp35.alpha_beta.fst.idx > grp35.average_fst.txt

#GROUP 3 vs 6
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF6 -P $THREADS  > grp36.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF6  -sfs grp36.2dSFS -fstout grp36.alpha_beta
realSFS fst print grp36.alpha_beta.fst.idx > grp36.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp36.alpha_beta.txt > grp36.fst
# Estimating average Fst in angsd
realSFS fst stats grp36.alpha_beta.fst.idx > grp36.average_fst.txt

#GROUP 3 vs 7
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF7 -P $THREADS  > grp37.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF7   -sfs grp37.2dSFS -fstout grp37.alpha_beta
realSFS fst print grp37.alpha_beta.fst.idx > grp37.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp37.alpha_beta.txt > grp37.fst
# Estimating average Fst in angsd
realSFS fst stats grp37.alpha_beta.fst.idx > grp37.average_fst.txt

#GROUP 3 vs 8
# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF8 -P $THREADS  > grp38.2dSFS
# Estimating Fst in angsd
realSFS fst index  $SAF3 $SAF8  -sfs grp38.2dSFS -fstout grp38.alpha_beta
realSFS fst print grp38.alpha_beta.fst.idx > grp38.alpha_beta.txt
awk '{ print $0 "\t" $3 / $4 }' grp38.alpha_beta.txt > grp38.fst
# Estimating average Fst in angsd
realSFS fst stats grp38.alpha_beta.fst.idx > grp38.average_fst.txt