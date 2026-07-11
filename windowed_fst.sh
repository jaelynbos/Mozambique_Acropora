#!/bin/bash -l

#SBATCH --job-name=angsd_fst_window
#SBATCH -o angsd_fst_window-%j.out 
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

## This script is used to get pairwise windowed Fst estimates from angsd for each population / group pair
DIR=/scratch/jbos/Moz_aligned_mil/sfs2
THREADS=16
SAF1=/scratch/jbos/Moz_aligned_mil/grp1_unlinked/grp1_unlinked.saf.idx
SAF2=/scratch/jbos/Moz_aligned_mil/grp37_unlinked/grp37_unlinked.saf.idx

# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF1 $SAF2 -P $THREADS  > $DIR/grp1vs37.2dSFS

cd $DIR

# Estimating Fst with angsd
realSFS fst index  $SAF1 $SAF2  -sfs grp1vs37.2dSFS -fstout grp1vs37.alpha_beta
realSFS fst print grp1vs37.alpha_beta.fst.idx > grp1vs37.alpha_beta.txt

# Estimating average Fst in angsd
realSFS fst stats2 grp1vs37.alpha_beta.fst.idx -win 50000 -step 10000 > grp1vs37.window_fst.txt 

SAF3=/scratch/jbos/Moz_aligned_mil/grp3_unlinked/grp3_unlinked.saf.idx
SAF4=/scratch/jbos/Moz_aligned_mil/grp7_unlinked/grp7_unlinked.saf.idx

# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF3 $SAF4 -P $THREADS  > $DIR/grp3vs7.2dSFS

# Estimating Fst with angsd
realSFS fst index  $SAF3 $SAF4  -sfs grp3vs7.2dSFS -fstout grp3vs7.alpha_beta
realSFS fst print grp3vs7.alpha_beta.fst.idx > grp3vs7.alpha_beta.txt

# Estimating average Fst in angsd
realSFS fst stats2 grp3vs7.alpha_beta.fst.idx -win 50000 -step 10000 > grp3vs7.window_fst.txt 

# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF1 $SAF4 -P $THREADS  > $DIR/grp1vs7.2dSFS

# Estimating Fst with angsd
realSFS fst index  $SAF1 $SAF4  -sfs grp1vs7.2dSFS -fstout grp1vs7.alpha_beta
realSFS fst print grp1vs7.alpha_beta.fst.idx > grp1vs7.alpha_beta.txt

# Estimating average Fst in angsd
realSFS fst stats2 grp1vs7.alpha_beta.fst.idx -win 50000 -step 10000 > grp1vs7.window_fst.txt 

# Generate the 2dSFS to be used as a prior for Fst estimation (and individual plots)
realSFS $SAF1 $SAF3 -P $THREADS  > $DIR/grp1vs3.2dSFS

# Estimating Fst with angsd
realSFS fst index  $SAF1 $SAF3  -sfs grp1vs3.2dSFS -fstout grp1vs3.alpha_beta
realSFS fst print grp1vs3.alpha_beta.fst.idx > grp1vs3.alpha_beta.txt

# Estimating average Fst in angsd
realSFS fst stats2 grp1vs3.alpha_beta.fst.idx -win 50000 -step 10000 > grp1vs3.window_fst.txt 