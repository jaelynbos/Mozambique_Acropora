#!/bin/bash

#SBATCH --job-name=GWAS
#SBATCH -o angsd_out/GWAS-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=720:00:00
#SBATCH --array=1-853%12

module load samtools 
module load angsd/0.940

DIR1=/home/jbos/Moz_reads
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

#OUTDIR1=/scratch/jbos/Moz_aligned_mil/GWAS1

#angsd -yBin $DIR1/DB_bleach.txt \
#	-doAsso 1 \
#	-GL 1 \
#	-doMajorMinor 1 \
#	-doMaf 1 \
#	-bam $DIR1/bam_names_DB_2024.txt \
#	-sites sites2.txt \
#	-cov $DIR1/DB_covariates.txt \
#	-Pvalue 1 \
#    -r ${CONTIG} \
#    -out ${OUTDIR1}/Acropora_gwas.${CONTIG}
	
	
#OUTDIR2=/scratch/jbos/Moz_aligned_mil/GWAS_Wimbe
#angsd -yBin $DIR1/DA_bleach_Wimbe.txt \
#	-doAsso 1 \
#	-GL 1 \
#	-doMajorMinor 1 \
#	-doMaf 1 \
#	-bam $DIR1/bam_names_DA_wimbe.txt \
#	-sites sites2.txt \
#	-cov $DIR1/DA_covariates.txt \
#	-Pvalue 1 \
#   -r ${CONTIG} \
#    -out ${OUTDIR2}/Acropora_gwas.${CONTIG}
	
OUTDIR3=/scratch/jbos/Moz_aligned_mil/GWAS_Bay
angsd -yBin $DIR1/bleach_Bay.txt \
	-doAsso 1 \
	-GL 1 \
	-doMajorMinor 1 \
	-doMaf 1 \
	-bam $DIR1/bam_names_bay.txt \
	-sites sites2.txt \
	-cov $DIR1/Bay_covariates.txt \
	-Pvalue 1 \
    -r ${CONTIG} \
    -out ${OUTDIR3}/Acropora_gwas.${CONTIG}