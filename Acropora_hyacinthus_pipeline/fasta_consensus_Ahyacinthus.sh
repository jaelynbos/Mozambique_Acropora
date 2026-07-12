#!/bin/bash

#SBATCH --job-name=fasta_consensus
#SBATCH -o angsd_out/fasta_consensus-%j.out
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

DIR=/scratch/jbos/Acropora_hyacinthus/consensus_fastas

bamlist_a=/scratch/jbos/Acropora_hyacinthus/bam_names_HA.txt

angsd -bam $bamlist_a \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/HA_consensus

bamlist_d=/scratch/jbos/Acropora_hyacinthus/bam_names_HD.txt

angsd -bam $bamlist_d \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/HD_consensus
	
bamlist_c=/scratch/jbos/Acropora_hyacinthus/bam_names_HC.txt

angsd -bam $bamlist_c \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/HC_consensus
	
bamlist_e=/scratch/jbos/Acropora_hyacinthus/bam_names_HE.txt

angsd -bam $bamlist_e \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-out $DIR/HE_consensus