#!/bin/bash

#SBATCH --job-name=angsd_safs
#SBATCH -o angsd_out/angsd_saf-%A_%a.out
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
module load ohpc
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt

BAMLIST1=/home/jbos/Moz_reads/bam_names_grp1.txt
OUTDIR1=/scratch/jbos/Moz_aligned_mil/grp1

SITES=sites1.txt

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

angsd -bam ${BAMLIST1} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
   -r ${CONTIG} \
	-sites $SITES \
   -out ${OUTDIR1}/Acropora_moz.${CONTIG}

BAMLIST2=/home/jbos/Moz_reads/bam_names_grp2.txt
OUTDIR2=/scratch/jbos/Moz_aligned_mil/grp2

angsd -bam ${BAMLIST2} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
   -r ${CONTIG} \
	-sites $SITES \
   -out ${OUTDIR2}/Acropora_moz.${CONTIG}


BAMLIST3=/home/jbos/Moz_reads/bam_names_grp3.txt
OUTDIR3=/scratch/jbos/Moz_aligned_mil/grp3

angsd -bam ${BAMLIST3} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
   -r ${CONTIG} \
	-sites $SITES \
   -out ${OUTDIR3}/Acropora_moz.${CONTIG}

BAMLIST4=/home/jbos/Moz_reads/bam_names_grp4.txt
OUTDIR4=/scratch/jbos/Moz_aligned_mil/grp4

angsd -bam ${BAMLIST4} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR4}/Acropora_moz.${CONTIG}
	
BAMLIST5=/home/jbos/Moz_reads/bam_names_grp5.txt
OUTDIR5=/scratch/jbos/Moz_aligned_mil/grp5

angsd -bam ${BAMLIST5} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR5}/Acropora_moz.${CONTIG}

BAMLIST6=/home/jbos/Moz_reads/bam_names_grp6.txt
OUTDIR6=/scratch/jbos/Moz_aligned_mil/grp6

angsd -bam ${BAMLIST6} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
  	 -doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR6}/Acropora_moz.${CONTIG}

BAMLIST7=/home/jbos/Moz_reads/bam_names_grp7.txt
OUTDIR7=/scratch/jbos/Moz_aligned_mil/grp7

angsd -bam ${BAMLIST7} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR7}/Acropora_moz.${CONTIG}

BAMLIST8=/home/jbos/Moz_reads/bam_names_grp8.txt
OUTDIR8=/scratch/jbos/Moz_aligned_mil/grp8

angsd -bam ${BAMLIST8} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 1 \
    -minMapQ 25 -minQ 30 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR8}/Acropora_moz.${CONTIG}