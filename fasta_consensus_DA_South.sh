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

DIR=/scratch/jbos/consensus_fastas
bamlist=/home/jbos/Moz_reads/bam_names_grp3.txt

angsd -bam $bamlist \
	-doFasta 2 \
	-doCounts 1 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-r sites_joint.txt  \
	-out $DIR/pop3_consensus