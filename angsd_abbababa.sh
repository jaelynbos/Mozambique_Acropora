#!/bin/bash

#SBATCH --job-name=abbababa
#SBATCH -o abbababa-%j.out
#SBATCH --cpus-per-task=8
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=200G
#SBATCH --time=720:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load angsd/0.940

OUTDIR=/scratch/jbos/abbababa

OUTGROUP=/scratch/jbos/consensus_fastas/isopora.fa.gz

max depth calculated as 234*150+52*20

samtools faidx $OUTGROUP

angsd -doAbbababa2 1 \
  -bam abbababa_bams_Moz.txt \
  -sizeFile abbababa_size_Moz.txt \
  -doCounts 1 \
  -out $OUTDIR/results_Moz.Angsd \
  -minQ 20 \
  -minMapQ 30 \
  -maxDepth 36140 \
  -blockSize 50000 \
  -anc $OUTGROUP \
  -p 8
  
angsd -doAbbababa2 1 \
  -bam abbababa_bams_AmSam.txt \
  -sizeFile abbababa_size_AmSam.txt \
  -doCounts 1 \
  -out $OUTDIR/results_AmSam.Angsd \
  -minQ 20 \
  -minMapQ 30 \
  -maxDepth 2655 \
  -blockSize 50000 \
  -anc $OUTGROUP \
  -p 8

module load r
module load miniconda3
conda activate angsd_r
 
Rscript estAvgError.R angsdFile="$OUTDIR/results_Moz.Angsd" out="result_Moz" sizeFile=abbababa_size_Moz.txt errFile=abbababa_err.txt nameFile=popNames_Moz.txt
Rscript estAvgError.R angsdFile="$OUTDIR/results_AmSam.Angsd" out="result_AmSam" sizeFile=abbababa_size_AmSam.txt errFile=abbababa_err.txt nameFile=popNames_AmSam.txt

