#!/bin/bash

#SBATCH --job-name=fasta_consensus3
#SBATCH -o angsd_out/fasta_consensus3-%j.out
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=96G
#SBATCH --time=96:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools 
module load angsd/0.940

DIR=/scratch/jbos/Acropora_hyacinthus/consensus_fastas_whole
BAMLIST1=/home/jbos/Moz_reads/bam_names_grp3.txt
MINDEPTH1=$(( $(wc -l < $BAMLIST1) * 5 ))
MAXDEPTH1=$(( $(wc -l < $BAMLIST1) * 150 ))
MININD1=$(( $(wc -l < $BAMLIST1) * 9 / 10 ))

angsd -bam $BAMLIST1 \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD1 \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH1 -setMinDepth $MINDEPTH1 \
	-out $DIR/DA_south_consensus
	
	
BAMLIST2=/home/jbos/Moz_reads/bam_names_grp7_noclones.txt
MINDEPTH2=$(( $(wc -l < $BAMLIST2) * 5 ))
MAXDEPTH2=$(( $(wc -l < $BAMLIST2) * 150 ))
MININD2=$(( $(wc -l < $BAMLIST2) * 9 / 10 ))

angsd -bam $BAMLIST2 \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD2 \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH2 -setMinDepth $MINDEPTH2 \
	-out $DIR/DA_north_consensus