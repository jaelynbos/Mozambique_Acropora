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

DIR=/scratch/jbos/consensus_fastas
bamlist=/home/jbos/Moz_reads/bam_names_grp7_noclones.txt

angsd -bam $bamlist \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/pop7_consensus