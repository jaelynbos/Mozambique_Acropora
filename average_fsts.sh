#!/bin/bash

#SBATCH --job-name=fst
#SBATCH -o fsts-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

DIR=/scratch/jbos/Moz_aligned_mil/sfs2

cd $DIR
realSFS fst stats grp1vs37.alpha_beta.fst.idx > AB.average_fst.txt

realSFS fst stats grp3vs7.alpha_beta.fst.idx > North_South.average_fst.txt

realSFS fst stats grp1vs3.alpha_beta.fst.idx > SppB_SouthA.average_fst.txt

realSFS fst stats grp1vs7.alpha_beta.fst.idx > SppB_NorthA.average_fst.txt