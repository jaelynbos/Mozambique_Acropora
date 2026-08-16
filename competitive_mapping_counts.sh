#!/bin/bash

#SBATCH --job-name=competitive_map_counts
#SBATCH -o competitive_map_counts-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=4
#SBATCH --mem=128G
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --time=72:00:00
#SBATCH --array=0-234%4

module load samtools

ACROPORA_CONTIGS="/home/jbos/bedfiles/acropora_contigs.bed"
CLAD_CONTIGS="/home/jbos/bedfiles/cladocopium_contigs.bed"
DUR_CONTIGS="/home/jbos/bedfiles/durusdinium_contigs.bed"
SYM_CONTIGS="/home/jbos/bedfiles/symbiodinium_contigs.bed"

OUTDIR="/scratch/jbos/competitive_mapping"

BAMLIST=("$OUTDIR"/*.bam)
BAM="${BAMLIST[$SLURM_ARRAY_TASK_ID]}"

sample=$(basename "$BAM" .bam)
samtools index "$BAM"
	
acro=$(samtools view -@ 4 -c -F 4 -L $ACROPORA_CONTIGS "$BAM")
printf "%s\t%s\n" "$sample" "$acro" >> "$OUTDIR/acropora_mapping_${sample}.txt"
	
clad=$(samtools view -@ 4 -c -F 4 -L $CLAD_CONTIGS "$BAM")
printf "%s\t%s\n" "$sample" "$clad" >> "$OUTDIR/cladocopium_mapping_${sample}.txt"
	
dur=$(samtools view -@ 4 -c -F 4 -L $DUR_CONTIGS "$BAM")
printf "%s\t%s\n" "$sample" "$dur" >> "$OUTDIR/durusdinium_mapping_${sample}.txt"
	
sym=$(samtools view -@ 4 -c -F 4 -L $SYM_CONTIGS "$BAM")
printf "%s\t%s\n" "$sample" "$sym" >> "$OUTDIR/symbiodinium_mapping_${sample}.txt"