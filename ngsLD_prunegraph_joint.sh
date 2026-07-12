#!/bin/bash

#SBATCH --job-name=prunegraph
#SBATCH --output ngsLD-%j.out
#SBATCH --error ngsLD-%j.err
#SBATCH --cpus-per-task=16
#SBATCH --time=336:00:00
#SBATCH --mem=800G 

# Script written by M. Clark, 2/24/2023
# updated 03/18/2026
# This script runs LD prunes a set of genotype likelihoods

# usage: 
# run_ngsLD_prune.sbatch

module load ngsld/1.2.0
module list

# define variables
DIR=/scratch/jbos/joint_Acropora/beagles
OUTDIR=${DIR}/LD_pruned
SCRIPT_DIR=/home/jbos/software/ngsLD/scripts
PRUNEGRAPH="/home/jbos/prune_graph/target/release/prune_graph"

if [ ! -d $OUTDIR ]; then mkdir -p $OUTDIR; fi

zcat $DIR/Acropora_all.mafs.gz | cut -f 1,2 | tail -n +2 | gzip > $DIR/all_sites.pos.gz

N_SITES=$(zcat $DIR/all_sites.pos.gz | wc -l)
MAX_KB_DIST=10 # informed by run_ngsLD_decay.sbatch
MAX_BP_DIST=$((MAX_KB_DIST * 1000))

module load ngsld/1.2.0
module list

ngsLD \
--geno $DIR/Acropora_all.beagle.gz \
--pos $DIR/all_sites.pos.gz \
--probs \
--n_ind 348 \
--n_sites $N_SITES \
--max_kb_dist $MAX_KB_DIST \
--n_threads 16 \
--out $OUTDIR/Acropora_pruned.ld 

module load miniconda3
conda activate rust_env 

# prune based on EM r^2
$PRUNEGRAPH \
    --in $OUTDIR/Acropora_pruned.ld \
    --weight "column_7" \
    --filter "column_3 <= 5000 && column_7 >= 0.5" \
    --n-threads 16 \
    --out $OUTDIR/Acropora_unlinked.pos

echo done! 

## DONE