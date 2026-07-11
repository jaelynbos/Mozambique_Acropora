#!/bin/bash

#SBATCH --job-name=angsd_glf
#SBATCH -o angsd_out/angsd_glf-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=720:00:00
#SBATCH --array=0-853%12
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
BAMLIST=/home/jbos/Moz_reads/bam_names_grp137.txt
OUTDIR=/scratch/jbos/Moz_aligned_mil/glf_grp137
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt


CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

angsd -bam ${BAMLIST} \
    -GL 1 \
    -doGlf 3 \
    -doMajorMinor 1 \
	-doPost 1 \
    -doMaf 1 \
    -minMapQ 25 -minQ 30 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
	-sites sites2.txt \
    -out ${OUTDIR}/Acropora_moz.${CONTIG}