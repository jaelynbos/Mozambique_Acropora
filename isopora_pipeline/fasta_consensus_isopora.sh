#!/bin/bash

#SBATCH --job-name=fasta_consensus1
#SBATCH -o fasta_consensus-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=500G
#SBATCH --time=720:00:00

module load samtools 
module load angsd/0.940

DIR=/scratch/jbos/consensus_fastas

angsd -bam isopora_bam.txt \
	-doFasta 2 \
	-P 8 \
	-doCounts 1 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/isopora