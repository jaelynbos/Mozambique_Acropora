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

SNPDIR=/home/jbos/Moz_scripts
DIR=/home/jbos/Moz_reads

awk 'BEGIN{OFS="\t"} {print $1, $2-1, $2}' $SNPDIR/sites2.txt > $SNPDIR/snps.bed

samtools depth -a -b $SNPDIR/snps.bed -f $DIR/bam_names_grp137.txt > $DIR/depth_all.txt

awk '{for(i=3;i<=NF;i++){sum+=$i; n++}} END{print sum/n}' $DIR/depth_all.txt

awk '
{
  for(i=3;i<=NF;i++){
    d=$i
    count[d]++
    n++
  }
}
END{
  # find the median position(s)
  mid1 = int((n+1)/2)
  mid2 = int((n+2)/2)
  cum = 0
  for (d=0; d<=100000; d++) {
    if (d in count) {
      cum += count[d]
      if (val1 == "" && cum >= mid1) val1 = d
      if (val2 == "" && cum >= mid2) val2 = d
    }
    if (val1 != "" && val2 != "") break
  }
  print (val1 + val2) / 2
}' $DIR/depth_all.txt