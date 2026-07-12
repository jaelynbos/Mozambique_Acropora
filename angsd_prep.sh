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
ls /scratch/jbos/Moz_aligned_mil/amillepora_bamfiles/*.bam > /home/jbos/Moz_reads/bamlist_amillepora.txt

#Samtools index reference
REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
samtools faidx $REF

#Make list of contigs
cut -f1 /home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna.fai > /home/jbos/Moz_reads/contig_list_Amillepora.txt


