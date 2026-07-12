#!/bin/bash
#SBATCH --job-name=ngsLD
#SBATCH -o ngsLD-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=500G
#SBATCH --time=720:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load ngsld
TARGET_BIN="5kb"

############################################################################################################################
DIR_B=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppB
OUTDIR_B=${DIR_B}/LD_pruned

# Generate pos file
zcat $DIR_B/Acropora_moz_all.mafs.gz | cut -f 1,2 | tail -n +2 | gzip > $DIR_B/sites.pos.gz

# Count sites
N_SITES=$(zcat $DIR_B/sites.pos.gz | wc -l)
echo "I found $N_SITES sites"

ngsLD \
    --geno $DIR_B/Acropora_moz_all.beagle.gz \
    --pos  $DIR_B/sites.pos.gz \
    --probs \
    --n_ind 73 \
    --n_sites $N_SITES \
    --max_kb_dist 20 \
    --n_threads 16 \
    --out $OUTDIR_B/Acropora_moz_B.ld

# Summarize LD by distance bin
awk '{print int($3/1000)"kb", $7}' $OUTDIR_B/Acropora_moz_B.ld | \
    awk '{sum[$1]+=$2; count[$1]++} END {for (k in sum) print k, sum[k]/count[k]}' | \
    sort -k1 -n | head -20
	
awk '{print int($3/1000)"kb", $7}' $OUTDIR_B/Acropora_moz_B.ld | \
    awk -v bin="$TARGET_BIN" '$1 == bin {print $2}' > $OUTDIR_B/${TARGET_BIN}_LD_values.txt

############################################################################################################################
DIR_N=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppA_north
OUTDIR_N=${DIR_N}/LD_pruned

# Generate pos file
zcat $DIR_N/Acropora_moz_all.mafs.gz | cut -f 1,2 | tail -n +2 | gzip > $DIR_N/sites.pos.gz

# Count sites
N_SITES=$(zcat $DIR_N/sites.pos.gz | wc -l)
echo "I found $N_SITES sites"

ngsLD \
    --geno $DIR_N/Acropora_moz_all.beagle.gz \
    --pos  $DIR_N/sites.pos.gz \
    --probs \
    --n_ind 77 \
    --n_sites $N_SITES \
    --max_kb_dist 20 \
    --n_threads 16 \
    --out $OUTDIR_N/Acropora_moz_north.ld

# Summarize LD by distance bin
awk '{print int($3/1000)"kb", $7}' $OUTDIR_N/Acropora_moz_north.ld | \
    awk '{sum[$1]+=$2; count[$1]++} END {for (k in sum) print k, sum[k]/count[k]}' | \
    sort -k1 -n | head -20
	
awk '{print int($3/1000)"kb", $7}' $OUTDIR_N/Acropora_moz_north.ld | \
    awk -v bin="$TARGET_BIN" '$1 == bin {print $2}' > $OUTDIR_N/${TARGET_BIN}_LD_values.txt

############################################################################################################################
DIR_S=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppA_south
OUTDIR_S=${DIR_S}/LD_pruned

# Generate pos file
zcat $DIR_S/Acropora_moz_all.mafs.gz | cut -f 1,2 | tail -n +2 | gzip > $DIR_S/sites.pos.gz

# Count sites
N_SITES=$(zcat $DIR_S/sites.pos.gz | wc -l)
echo "I found $N_SITES sites"

ngsLD \
    --geno $DIR_S/Acropora_moz_all.beagle.gz \
    --pos  $DIR_S/sites.pos.gz \
    --probs \
    --n_ind 86 \
    --n_sites $N_SITES \
    --max_kb_dist 20 \
    --n_threads 16 \
    --out $OUTDIR_S/Acropora_moz_A_south.ld

# Summarize LD by distance bin
awk '{print int($3/1000)"kb", $7}' $OUTDIR_S/Acropora_moz_A_south.ld | \
    awk '{sum[$1]+=$2; count[$1]++} END {for (k in sum) print k, sum[k]/count[k]}' | \
    sort -k1 -n | head -20

awk '{print int($3/1000)"kb", $7}' $OUTDIR_S/Acropora_moz_A_south.ld | \
    awk -v bin="$TARGET_BIN" '$1 == bin {print $2}' > $OUTDIR_S/${TARGET_BIN}_LD_values.txt