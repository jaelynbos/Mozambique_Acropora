#!/bin/bash

#SBATCH --job-name=fasta_consensus7
#SBATCH -o angsd_out/fasta_consensus7-%j.out
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=296G
#SBATCH --time=96:00:00

module load samtools 
module load angsd/0.940

DIR=/scratch/jbos/Acropora_hyacinthus/consensus_fastas_whole
BAMLIST=/home/jbos/Moz_reads/bam_names_grp1.txt
MINDEPTH=$(( $(wc -l < $BAMLIST) * 5 ))
MAXDEPTH=$(( $(wc -l < $BAMLIST) * 150 ))
MININD=$(( $(wc -l < $BAMLIST) * 9 / 10 ))

angsd -bam $BAMLIST \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH -setMinDepth $MINDEPTH \
	-out $DIR/DB_consensus