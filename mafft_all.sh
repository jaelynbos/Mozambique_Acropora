#!/bin/bash

#SBATCH --job-name=mafft
#SBATCH -o mafft_nucleotide-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

module load samtools

DIR=/scratch/jbos/Acropora_hyacinthus/consensus_fastas_whole
OUTDIR=/scratch/jbos/mafft_alignments_wholegenome

mkdir -p $OUTDIR

cd $DIR
for file in *consensus.fasta
do
    sample=$(basename "$file" _consensus.fasta)
	samtools faidx "$sample"_consensus.fasta NC_058072.1:20450110-20468842 | sed "s/^>.*/>${sample}/"  > $OUTDIR/${sample}_gene1.fasta
	samtools faidx "$sample"_consensus.fasta NC_058072.1:20495840-20513836 | sed "s/^>.*/>${sample}/" > $OUTDIR/${sample}_gene2.fasta
	samtools faidx "$sample"_consensus.fasta NC_058072.1:20483176-20486793 | sed "s/^>.*/>${sample}/" > $OUTDIR/${sample}_noncoding2.fasta
	samtools faidx "$sample"_consensus.fasta NC_058072.1:20350000-20570010 | sed "s/^>.*/>${sample}/" > $OUTDIR/${sample}_hes1_rose.fasta
done

cd $OUTDIR

module load miniconda3
conda activate mafft 

cat *_gene1.fasta > gene1.fasta
cat *_gene2.fasta > gene2.fasta
cat *_hes1_rose.fasta > hes1_rose.fasta
cat *_noncoding2.fasta > noncoding2.fasta

mafft --auto gene1.fasta > gene1.aln
mafft --auto gene2.fasta > gene2.aln
mafft --auto hes1_rose.fasta > hes1_rose.aln
mafft --auto noncoding2.fasta > noncoding2.aln
