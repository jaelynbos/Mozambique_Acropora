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

DIR1=/scratch/jbos/Moz_aligned_mil/grp1_unlinked
DIR2=/scratch/jbos/Moz_aligned_mil/grp3_unlinked
DIR3=/scratch/jbos/Moz_aligned_mil/grp7_unlinked
DIR4=/scratch/jbos/Moz_aligned_mil/grp37_unlinked
DIR5=/scratch/jbos/Moz_aligned_mil/grp137_unlinked

realSFS cat $DIR1/Acropora_moz.NC*saf.idx -outnames $DIR1/grp1_unlinked
realSFS cat $DIR2/Acropora_moz.NC*saf.idx -outnames $DIR2/grp3_unlinked
realSFS cat $DIR3/Acropora_moz.NC*saf.idx -outnames $DIR3/grp7_unlinked
realSFS cat $DIR4/Acropora_moz.NC*saf.idx -outnames $DIR4/grp37_unlinked
realSFS cat $DIR5/Acropora_moz.NC*saf.idx -outnames $DIR5/grp137_unlinked

realSFS $DIR1/grp1_unlinked.saf.idx -P 8 -fold 1 > $DIR1/grp1.sfs
realSFS $DIR2/grp3_unlinked.saf.idx -P 8 -fold 1 > $DIR2/grp3.sfs
realSFS $DIR3/grp7_unlinked.saf.idx -P 8 -fold 1 > $DIR3/grp7.sfs
realSFS $DIR4/grp37_unlinked.saf.idx -P 8 -fold 1 > $DIR4/grp37.sfs
realSFS $DIR5/grp137_unlinked.saf.idx -P 8 -fold 1 > $DIR5/grp137.sfs
