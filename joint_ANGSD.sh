#!/bin/bash

#SBATCH --job-name=angsd
#SBATCH -o angsd_out/angsd_b-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=720:00:00
#SBATCH --array=0-853%12

#Should be through 853
module load samtools
module load ohpc
module load angsd/0.940

REF=/home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna
BAMLIST=Acropora_bams.txt
OUTDIR=/scratch/jbos/joint_Acropora/beagles
CONTIG_LIST=/home/jbos/Moz_reads/contig_list_Amillepora.txt

MINDEPTH=$(( $(wc -l < $BAMLIST) * 2 ))
MAXDEPTH=$(( $(wc -l < $BAMLIST) * 120 ))
MININD=$(( $(wc -l < $BAMLIST) * 8 / 10 ))

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

angsd -bam ${BAMLIST} \
    -GL 1 \
    -doGlf 2 \
    -doMajorMinor 2 \
	-doPost 1 \
    -doMaf 1 \
	-minMaf 0.01 \
    -minMapQ 25 -minQ 30 \
    -SNP_pval 1e-6 \
    -minInd $MININD \
    -uniqueOnly 1 -remove_bads 1 \
    -skipTriallelic 0 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth $MAXDEPTH -setMinDepth $MINDEPTH \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR}/Acropora.${CONTIG}
