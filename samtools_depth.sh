#!/bin/bash

#SBATCH --job-name=samtools_depth
#SBATCH -o samtools_depth-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --time=72:00:00

module load samtools
module load miniconda3
conda activate datamash

DIR=/scratch/jbos/Moz_aligned_mil/amillepora_bamfiles
PERSAMPLE=$DIR/depth_per_sample.txt
OVERALL=$DIR/depth_overall_summary.txt

#for file in $DIR/*.sorted.bam
#do
#    sample=$(basename "$file" .sorted.bam)
#    samtools depth "$file" > $DIR/${sample}.depth
#done

echo -e "sample\tmean_depth\tmedian_depth" > "$PERSAMPLE"

for file in $DIR/*.sorted.bam
do
    sample=$(basename "$file" .sorted.bam)
    depthfile=$DIR/${sample}.depth
    samtools depth "$file" > "$depthfile"
    read mean median < <(
        awk '{print $3}' "$depthfile" | datamash mean 1 median 1
    )
    echo -e "${sample}\t${mean}\t${median}" >> "$PERSAMPLE"
done

read mean_of_means sd_of_means < <(tail -n +2 "$PERSAMPLE" | awk '{print $2}' | datamash mean 1 sstdev 1)
read mean_of_medians sd_of_medians < <(tail -n +2 "$PERSAMPLE" | awk '{print $3}' | datamash mean 1 sstdev 1)

{
    echo -e "metric\tvalue"
    echo -e "mean_of_per_sample_means\t${mean_of_means}"
    echo -e "sd_of_per_sample_means\t${sd_of_means}"
    echo -e "mean_of_per_sample_medians\t${mean_of_medians}"
    echo -e "sd_of_per_sample_medians\t${sd_of_medians}"
} > "$OVERALL"

cat "$OVERALL"