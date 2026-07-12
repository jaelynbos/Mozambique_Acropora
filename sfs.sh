#!/bin/bash

#SBATCH --job-name=sfs
#SBATCH -o sfs-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=296G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load ohpc
module load angsd/0.940

DIR1=/scratch/jbos/Moz_aligned_mil/grp1
DIR2=/scratch/jbos/Moz_aligned_mil/grp2
DIR3=/scratch/jbos/Moz_aligned_mil/grp3
DIR4=/scratch/jbos/Moz_aligned_mil/grp4
DIR5=/scratch/jbos/Moz_aligned_mil/grp5
DIR6=/scratch/jbos/Moz_aligned_mil/grp6
DIR7=/scratch/jbos/Moz_aligned_mil/grp7
DIR8=/scratch/jbos/Moz_aligned_mil/grp8

OUTDIR=/scratch/jbos/Moz_aligned_mil/sfs

realSFS cat $DIR1/Acropora_moz.NC*saf.idx -outnames $DIR1/grp1_saf
realSFS cat $DIR2/Acropora_moz.NC*saf.idx -outnames $DIR2/grp2_saf
realSFS cat $DIR3/Acropora_moz.NC*saf.idx -outnames $DIR3/grp3_saf
realSFS cat $DIR4/Acropora_moz.NC*saf.idx -outnames $DIR4/grp4_saf
realSFS cat $DIR5/Acropora_moz.NC*saf.idx -outnames $DIR5/grp5_saf
realSFS cat $DIR6/Acropora_moz.NC*saf.idx -outnames $DIR6/grp6_saf
realSFS cat $DIR7/Acropora_moz.NC*saf.idx -outnames $DIR7/grp7_saf
realSFS cat $DIR8/Acropora_moz.NC*saf.idx -outnames $DIR8/grp8_saf

realSFS $DIR1/grp1_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp1.sfs
realSFS $DIR2/grp2_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp2.sfs
realSFS $DIR3/grp3_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp3.sfs
realSFS $DIR4/grp4_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp4.sfs
realSFS $DIR5/grp5_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp5.sfs
realSFS $DIR6/grp6_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp6.sfs
realSFS $DIR7/grp7_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp7.sfs
realSFS $DIR8/grp8_saf.saf.idx -P 8 -fold 1 > $OUTDIR/grp8.sfs