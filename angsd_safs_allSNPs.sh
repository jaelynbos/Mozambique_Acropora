#!/bin/bash

#SBATCH --job-name=angsd_safs2
#SBATCH -o angsd_out/angsd_saf2-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=200G
#SBATCH --time=720:00:00
#SBATCH --array=0-853%6
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load samtools
module load ohpc
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

BAMLIST1=/home/jbos/Moz_reads/bam_names_grp1.txt
OUTDIR1=/scratch/jbos/Moz_aligned_mil/DB_safs_allSNPs

MINDEPTH1=$(( $(wc -l < $BAMLIST1) * 5 ))
MAXDEPTH1=$(( $(wc -l < $BAMLIST1) * 150 ))
MININD1=$(( $(wc -l < $BAMLIST1) * 9 / 10 ))

angsd -bam ${BAMLIST1} \
    -GL 1 \
	-doSaf 1 \
	-doMajorMinor 2 \
    -minMapQ 25 -minQ 30 \
	-minInd $MININD1 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH1 -setMinDepth $MINDEPTH1 \
    -P 2 \
    -ref ${REF} \
	-anc ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR1}/Acropora_moz.${CONTIG}


BAMLIST37=/home/jbos/Moz_reads/bam_names_grp37_noclones.txt
OUTDIR37=/scratch/jbos/Moz_aligned_mil/DA_safs_allSNPs

MINDEPTH37=$(( $(wc -l < $BAMLIST37) * 5 ))
MAXDEPTH37=$(( $(wc -l < $BAMLIST37) * 150 ))
MININD37=$(( $(wc -l < $BAMLIST37) * 9 / 10 ))

angsd -bam ${BAMLIST37} \
    -GL 1 \
	-doSaf 1 \
	-doMajorMinor 2 \
    -minMapQ 25 -minQ 30 \
	-minInd $MININD37 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH37 -setMinDepth $MINDEPTH37 \
    -P 2 \
    -ref ${REF} \
	-anc ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR37}/Acropora_moz.${CONTIG}

BAMLIST3=/home/jbos/Moz_reads/bam_names_grp3.txt
OUTDIR3=/scratch/jbos/Moz_aligned_mil/DA_south_safs_allSNPs

MINDEPTH3=$(( $(wc -l < $BAMLIST3) * 5 ))
MAXDEPTH3=$(( $(wc -l < $BAMLIST3) * 150 ))
MININD3=$(( $(wc -l < $BAMLIST3) * 9 / 10 ))

angsd -bam ${BAMLIST3} \
    -GL 1 \
	-doSaf 1 \
	-doMajorMinor 2 \
    -minMapQ 25 -minQ 30 \
	-minInd $MININD3 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH3 -setMinDepth $MINDEPTH3 \
    -P 2 \
    -ref ${REF} \
	-anc ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR3}/Acropora_moz.${CONTIG}

BAMLIST7=/home/jbos/Moz_reads/bam_names_grp7_noclones.txt
OUTDIR7=/scratch/jbos/Moz_aligned_mil/DA_north_safs_allSNPs

MINDEPTH7=$(( $(wc -l < $BAMLIST7) * 5 ))
MAXDEPTH7=$(( $(wc -l < $BAMLIST7) * 150 ))
MININD7=$(( $(wc -l < $BAMLIST7) * 9 / 10 ))

angsd -bam ${BAMLIST7} \
    -GL 1 \
	-doSaf 1 \
	-doMajorMinor 2 \
    -minMapQ 25 -minQ 30 \
	-minInd $MININD7 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH7 -setMinDepth $MINDEPTH7 \
    -P 2 \
    -ref ${REF} \
	-anc ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR7}/Acropora_moz.${CONTIG}