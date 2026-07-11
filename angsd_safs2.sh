#!/bin/bash

#SBATCH --job-name=angsd_safs2
#SBATCH -o angsd_out/angsd_saf2-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=200G
#SBATCH --time=720:00:00
#SBATCH --array=0-13%12
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

#Change sbatch back to array=0-853%12

module load samtools
module load ohpc
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt

BAMLIST1=/home/jbos/Moz_reads/bam_names_grp1.txt
OUTDIR1=/scratch/jbos/Moz_aligned_mil/grp1_unlinked

SITES=sites2.txt

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

angsd -bam ${BAMLIST1} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
   -r ${CONTIG} \
	-sites $SITES \
   -out ${OUTDIR1}/Acropora_moz.${CONTIG}

BAMLIST3=/home/jbos/Moz_reads/bam_names_grp3.txt
OUTDIR3=/scratch/jbos/Moz_aligned_mil/grp3_unlinked
angsd -bam ${BAMLIST3} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
   -r ${CONTIG} \
	-sites $SITES \
   -out ${OUTDIR3}/Acropora_moz.${CONTIG}

BAMLIST7=/home/jbos/Moz_reads/bam_names_grp7_noclones.txt
OUTDIR7=/scratch/jbos/Moz_aligned_mil/grp7_unlinked
angsd -bam ${BAMLIST7} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR7}/Acropora_moz.${CONTIG}

BAMLIST37=/home/jbos/Moz_reads/bam_names_grp37_noclones.txt
OUTDIR37=/scratch/jbos/Moz_aligned_mil/grp37_unlinked
angsd -bam ${BAMLIST37} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR37}/Acropora_moz.${CONTIG}

BAMLIST137=/home/jbos/Moz_reads/bam_names_grp137_noclones.txt
OUTDIR137=/scratch/jbos/Moz_aligned_mil/grp137_unlinked
angsd -bam ${BAMLIST137} \
    -GL 1 \
	 -doSaf 1 \
	 -doMajorMinor 2 \
	-doCounts 1 \
    -P 2 \
    -ref ${REF} \
	 -anc ${REF} \
    -r ${CONTIG} \
	-sites $SITES \
    -out ${OUTDIR137}/Acropora_moz.${CONTIG}