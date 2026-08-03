#!/bin/bash

#SBATCH --job-name=mafft
#SBATCH -o mafft_nucleotide-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=72:00:00

module load samtools
module load samtools

OUTDIR=/scratch/jbos/hes1_sequences

mkdir $OUTDIR

cd /scratch/jbos/Acropora_hyacinthus/consensus_fastas
for file in *.fa.gz
do
    sample=$(basename "$file" .fa.gz)
	samtools faidx $sample.fa.gz NC_058072.1:20450110-20468842 > $OUTDIR/${sample}_mRNA3.fasta # old gene 12599 is in here
	samtools faidx $sample.fa.gz NC_058072.1:20495840-20513836 > $OUTDIR/${sample}_mRNA5.fasta
	samtools faidx $sample.fa.gz NC_058072.1:20483176-20486793 > $OUTDIR/${sample}_noncoding2.fasta
	samtools faidx $sample.fa.gz NC_058072.1:20350000-20570000 > $OUTDIR/${sample}_hes1_rose.fasta
done

cd /scratch/jbos/consensus_fastas
for file in *consensus.fa.gz
do
    sample=$(basename "$file" .fa.gz)
	samtools faidx $sample.fa.gz NC_058072.1:20450110-20468842 > $OUTDIR/${sample}_mRNA3.fasta
	samtools faidx $sample.fa.gz NC_058072.1:20495840-20513836 > $OUTDIR/${sample}_mRNA5.fasta
	samtools faidx $sample.fa.gz NC_058072.1:20483176-20486793 > $OUTDIR/${sample}_noncoding2.fasta
	samtools faidx $sample.fa.gz NC_058072.1:20350000-20570000 > $OUTDIR/${sample}_hes1_rose.fasta
done

cd $OUTDIR

cat *_mRNA3.fasta > mRNA3.fasta
cat *_mRNA5.fasta > mRNA5.fasta
cat *_hes1_rose.fasta > hes1_rose.fasta
cat *_noncoding2.fasta > noncoding2.fasta

module load miniconda3
conda activate mafft 

mafft --auto mRNA3.fasta > mRNA3.aln
mafft --auto mRNA5.fasta > mRNA5.aln
mafft --auto hes1_rose.fasta > hes1_rose.aln
mafft --auto noncoding2.fasta > noncoding2.aln
