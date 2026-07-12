#!/bin/bash

#SBATCH --job-name=angsd
#SBATCH -o angsd_out/angsd_b-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=720:00:00
#SBATCH --array=0-853%12

module load samtools
module load ohpc
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt
CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

BAMLIST_B=/home/jbos/Moz_reads/bam_names_grp1.txt
OUTDIR_B=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppB

MINDEPTH_B=$(( $(wc -l < $BAMLIST_B) * 5 ))
MAXDEPTH_B=$(( $(wc -l < $BAMLIST_B) * 150 ))

MININD_B=$(( $(wc -l < $BAMLIST_B) * 9 / 10 ))

angsd -bam ${BAMLIST_B} \
    -GL 1 \
    -doGlf 2 \
    -doMajorMinor 1 \
	-doPost 1 \
    -doMaf 1 \
    -minMapQ 25 -minQ 30 \
    -SNP_pval 1e-6 \
    -minInd $MININD_B \
    -uniqueOnly 1 -remove_bads 1 \
    -skipTriallelic 1 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_B -setMinDepth $MINDEPTH_B \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR_B}/Acropora_moz.${CONTIG}
	
BAMLIST_A_North=/home/jbos/Moz_reads/bam_names_grp7.txt
OUTDIR_A_North=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppA_north

MINDEPTH_A_North=$(( $(wc -l < $BAMLIST_A_North) * 5 ))
MAXDEPTH_A_North=$(( $(wc -l < $BAMLIST_A_North) * 150 ))

MININD_A_North=$(( $(wc -l < $BAMLIST_A_North) * 9 / 10 ))

angsd -bam ${BAMLIST_A_North} \
    -GL 1 \
    -doGlf 2 \
    -doMajorMinor 1 \
	-doPost 1 \
    -doMaf 1 \
    -minMapQ 25 -minQ 30 \
    -SNP_pval 1e-6 \
    -minInd $MININD_A_North \
    -uniqueOnly 1 -remove_bads 1 \
    -skipTriallelic 1 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_A_North -setMinDepth $MINDEPTH_A_North \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR_A_North}/Acropora_moz.${CONTIG}
	
BAMLIST_A_south=/home/jbos/Moz_reads/bam_names_grp3.txt
OUTDIR_A_south=/scratch/jbos/Moz_aligned_mil/beagle_contigs_SppA_south

MINDEPTH_A_south=$(( $(wc -l < $BAMLIST_A_south) * 5 ))
MAXDEPTH_A_south=$(( $(wc -l < $BAMLIST_A_south) * 150 ))

MININD_A_south=$(( $(wc -l < $BAMLIST_A_south) * 9 / 10 ))

angsd -bam ${BAMLIST_A_south} \
    -GL 1 \
    -doGlf 2 \
    -doMajorMinor 1 \
	-doPost 1 \
    -doMaf 1 \
    -minMapQ 25 -minQ 30 \
    -SNP_pval 1e-6 \
    -minInd $MININD_A_south \
    -uniqueOnly 1 -remove_bads 1 \
    -skipTriallelic 1 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH_A_south -setMinDepth $MINDEPTH_A_south \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR_A_south}/Acropora_moz.${CONTIG}