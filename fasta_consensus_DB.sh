#!/bin/bash

#SBATCH --job-name=fasta_consensus1
#SBATCH -o angsd_out/fasta_consensus1-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=296G
#SBATCH --time=720:00:00

module load samtools 
module load angsd/0.940

DIR=/scratch/jbos/consensus_fastas
bamlist1=/home/jbos/Moz_reads/bam_names_grp1.txt

angsd -bam $bamlist1 \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/pop1_consensus
	
angsd -bam /scratch/jbos/isopora/amillepora_samfiles/ERR16728350.sam \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/isopora