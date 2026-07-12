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
module load miniconda3
conda activate mafft 

OUTDIR=/scratch/jbos/genes_by_chrom

cd /scratch/jbos/Acropora_hyacinthus/consensus_fastas
for file in *.fa.gz
do
    sample=$(basename "$file" .fa.gz)
	samtools faidx $sample.fa.gz NC_058066.1:15361-48114 > $OUTDIR/${sample}_mRNA1.fasta
	samtools faidx $sample.fa.gz NC_058067.1:9987-27857 > $OUTDIR/${sample}_mRNA2.fasta
	samtools faidx $sample.fa.gz NC_058068.1:11254-31133 > $OUTDIR/${sample}_mRNA3.fasta
	samtools faidx $sample.fa.gz NC_058069.1:31488-32603 > $OUTDIR/${sample}_mRNA4.fasta
	samtools faidx $sample.fa.gz NC_058070.1:22880-32699 > $OUTDIR/${sample}_mRNA5.fasta
	samtools faidx $sample.fa.gz NC_058071.1:10143-12469 > $OUTDIR/${sample}_mRNA6.fasta
	samtools faidx $sample.fa.gz NC_058072.1:2217-3374 > $OUTDIR/${sample}_mRNA7.fasta
	samtools faidx $sample.fa.gz NC_058073.1:38682-40346 > $OUTDIR/${sample}_mRNA8.fasta
	samtools faidx $sample.fa.gz NC_058074.1:5017-17684 > $OUTDIR/${sample}_mRNA9.fasta
	samtools faidx $sample.fa.gz NC_058075.1:12579-14608 > $OUTDIR/${sample}_mRNA10.fasta
	samtools faidx $sample.fa.gz NC_058076.1:6-11456 > $OUTDIR/${sample}_mRNA11.fasta
	samtools faidx $sample.fa.gz NC_058077.1:16509-19314 > $OUTDIR/${sample}_mRNA12.fasta
	samtools faidx $sample.fa.gz NC_058078.1:1037-2814 > $OUTDIR/${sample}_mRNA13.fasta
	samtools faidx $sample.fa.gz NC_058079.1:280-10760 > $OUTDIR/${sample}_mRNA14.fasta
done
	
cd /scratch/jbos/consensus_fastas
for file in *consensus.fa.gz
do
    sample=$(basename "$file" .fa.gz)
	samtools faidx $sample.fa.gz NC_058066.1:15361-48114 > $OUTDIR/${sample}_mRNA1.fasta
	samtools faidx $sample.fa.gz NC_058067.1:9987-27857 > $OUTDIR/${sample}_mRNA2.fasta
	samtools faidx $sample.fa.gz NC_058068.1:11254-31133 > $OUTDIR/${sample}_mRNA3.fasta
	samtools faidx $sample.fa.gz NC_058069.1:31488-32603 > $OUTDIR/${sample}_mRNA4.fasta
	samtools faidx $sample.fa.gz NC_058070.1:22880-32699 > $OUTDIR/${sample}_mRNA5.fasta
	samtools faidx $sample.fa.gz NC_058071.1:10143-12469 > $OUTDIR/${sample}_mRNA6.fasta
	samtools faidx $sample.fa.gz NC_058072.1:2217-3374 > $OUTDIR/${sample}_mRNA7.fasta
	samtools faidx $sample.fa.gz NC_058073.1:38682-40346 > $OUTDIR/${sample}_mRNA8.fasta
	samtools faidx $sample.fa.gz NC_058074.1:5017-17684 > $OUTDIR/${sample}_mRNA9.fasta
	samtools faidx $sample.fa.gz NC_058075.1:12579-14608 > $OUTDIR/${sample}_mRNA10.fasta
	samtools faidx $sample.fa.gz NC_058076.1:6-11456 > $OUTDIR/${sample}_mRNA11.fasta
	samtools faidx $sample.fa.gz NC_058077.1:16509-19314 > $OUTDIR/${sample}_mRNA12.fasta
	samtools faidx $sample.fa.gz NC_058078.1:1037-2814 > $OUTDIR/${sample}_mRNA13.fasta
	samtools faidx $sample.fa.gz NC_058079.1:280-10760 > $OUTDIR/${sample}_mRNA14.fasta
done

cd $OUTDIR
cat *_mRNA1.fasta > mRNA1.fasta
cat *_mRNA2.fasta > mRNA2.fasta
cat *_mRNA3.fasta > mRNA3.fasta
cat *_mRNA4.fasta > mRNA4.fasta
cat *_mRNA5.fasta > mRNA5.fasta
cat *_mRNA6.fasta > mRNA6.fasta
cat *_mRNA7.fasta > mRNA7.fasta
cat *_mRNA8.fasta > mRNA8.fasta
cat *_mRNA9.fasta > mRNA9.fasta
cat *_mRNA10.fasta > mRNA10.fasta
cat *_mRNA11.fasta > mRNA11.fasta
cat *_mRNA12.fasta > mRNA12.fasta
cat *_mRNA13.fasta > mRNA13.fasta
cat *_mRNA14.fasta > mRNA14.fasta

mafft --auto mRNA1.fasta > mRNA1.aln
mafft --auto mRNA2.fasta > mRNA2.aln
mafft --auto mRNA3.fasta > mRNA3.aln
mafft --auto mRNA4.fasta > mRNA4.aln
mafft --auto mRNA5.fasta > mRNA5.aln
mafft --auto mRNA6.fasta > mRNA6.aln
mafft --auto mRNA7.fasta > mRNA7.aln
mafft --auto mRNA8.fasta > mRNA8.aln
mafft --auto mRNA9.fasta > mRNA9.aln
mafft --auto mRNA10.fasta > mRNA10.aln
mafft --auto mRNA11.fasta > mRNA11.aln
mafft --auto mRNA12.fasta > mRNA12.aln
mafft --auto mRNA13.fasta > mRNA13.aln
mafft --auto mRNA14.fasta > mRNA14.aln