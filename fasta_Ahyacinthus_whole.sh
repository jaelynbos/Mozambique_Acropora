#!/bin/bash

#SBATCH --job-name=fasta_consensus_hyacinthus
#SBATCH -o angsd_out/fasta_consensus-%j.out
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=296G
#SBATCH --time=96:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools 
module load angsd/0.940

DIR=/scratch/jbos/Acropora_hyacinthus/consensus_fastas_whole
mkdir -p $DIR

bamlist_a=/scratch/jbos/Acropora_hyacinthus/bam_names_HA.txt
MINDEPTH_a=$(( $(wc -l < $bamlist_a) * 1 ))
MAXDEPTH_a=$(( $(wc -l < $bamlist_a) * 50 ))
MININD_a=$(( $(wc -l < $bamlist_a) * 9 / 10 ))

angsd -bam $bamlist_a \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD_a \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_a -setMinDepth $MINDEPTH_a \
	-out $DIR/HA_consensus

bamlist_d=/scratch/jbos/Acropora_hyacinthus/bam_names_HD.txt
MINDEPTH_d=$(( $(wc -l < $bamlist_d) * 1 ))
MAXDEPTH_d=$(( $(wc -l < $bamlist_d) * 50 ))
MININD_d=$(( $(wc -l < $bamlist_d) * 9 / 10 ))

angsd -bam $bamlist_d \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD_d \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_d -setMinDepth $MINDEPTH_d \
	-out $DIR/HD_consensus
	
bamlist_c=/scratch/jbos/Acropora_hyacinthus/bam_names_HC.txt
MINDEPTH_c=$(( $(wc -l < $bamlist_c) * 1 ))
MAXDEPTH_c=$(( $(wc -l < $bamlist_c) * 50 ))
MININD_c=$(( $(wc -l < $bamlist_c) * 9 / 10 ))

angsd -bam $bamlist_c \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD_c \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_c -setMinDepth $MINDEPTH_c \
	-out $DIR/HC_consensus
	
bamlist_e=/scratch/jbos/Acropora_hyacinthus/bam_names_HE.txt
MINDEPTH_e=$(( $(wc -l < $bamlist_e) * 1 ))
MAXDEPTH_e=$(( $(wc -l < $bamlist_e) * 50 ))
MININD_e=$(( $(wc -l < $bamlist_e) * 9 / 10 ))

angsd -bam $bamlist_e \
	-doFasta 2 \
	-P 8 \
	-minMapQ 25 -minQ 30 \
	-minInd $MININD_e \
	-doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_e -setMinDepth $MINDEPTH_e \
	-out $DIR/HE_consensus