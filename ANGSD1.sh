#!/bin/bash

#SBATCH --job-name=angsd
#SBATCH -o angsd_out/angsd-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64G
#SBATCH --time=720:00:00
#SBATCH --array=1-481%12

module load samtools
module load ohpc
module load angsd/0.940

REF=/home/jbos/ncbi/amuricata_ncbi.fna
BAMLIST=/home/jbos/Moz_reads/spp1_inds.txt
OUTDIR=/scratch/jbos/Moz_intermediates/beagle_contigs_spp1
CONTIG_LIST=/home/jbos/Moz_reads/contig_list.txt

mkdir $OUTDIR
mkdir -p ${OUTDIR}/logs

CONTIG=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${CONTIG_LIST})

angsd -bam ${BAMLIST} \
    -GL 1 \
    -doGlf 2 \
    -doMajorMinor 1 \
	-doGeno 1 \
	-doPost 1 \
    -doMaf 1 \
    -minMapQ 25 -minQ 30 \
    -SNP_pval 1e-6 \
    -minInd 2 \
    -uniqueOnly 1 -remove_bads 1 \
    -skipTriallelic 0 \
    -doCounts 1 -doDepth 1 -dumpCounts 1 -setmaxdepth 150 -setMinDepth 3 \
    -P 2 \
    -ref ${REF} \
    -r ${CONTIG} \
    -out ${OUTDIR}/Acropora_moz.${CONTIG}