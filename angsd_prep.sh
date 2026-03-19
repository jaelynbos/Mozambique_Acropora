#!/bin/bash

#SBATCH --job-name=angsd_prep
#SBATCH -o angsd_prep-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=24:00:00

module load samtools

#Make list of bamfiles
ls /scratch/jbos/Moz_intermediates/amuricata_bamfiles/*.bam > /home/jbos/Moz_reads/bamlist.txt

#Samtools index reference
REF=/home/jbos/ncbi/amuricata_ncbi.fna
samtools faidx $REF

#Make list of contigs
cut -f1 /home/jbos/ncbi/amuricata_ncbi.fna.fai > /home/jbos/Moz_reads/contig_list.txt


