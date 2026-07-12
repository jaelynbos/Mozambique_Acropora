#!/bin/bash

#SBATCH --job-name=pcangsd
#SBATCH -o pcangsd-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=286G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load pcangsd

DIR=/scratch/jbos/joint_Acropora/beagles
pcangsd -b $DIR/Acropora_unlinked.beagle.gz  --maf 0.05 --threads 16 --it 1000 --out $DIR/angsd_acropora_joint
pcangsd -b $DIR/Acropora_unlinked.beagle.gz  --admix  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_acropora_admix

zcat $DIR/Acropora_unlinked.beagle.gz | awk 'BEGIN{OFS="\t"} NR==1 { print; next } {
    pos = $1
    split(pos, a, "_")
    position = a[length(a)]           # last element = position
    sub("_"position"$", "", pos)      # strip trailing _position to get chrom
    if(pos=="NC_058072.1" && position+0>=20350000 && position+0<=20570000) print
}' | gzip > $DIR/hes1.beagle.gz

pcangsd -b $DIR/hes1.beagle.gz  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_hes1_pca
pcangsd -b $DIR/hes1.beagle.gz  --admix  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_hes1_admix

zcat $DIR/Acropora_unlinked.beagle.gz | awk 'BEGIN{OFS="\t"} NR==1 { print; next } {
    pos = $1
    split(pos, a, "_")
    position = a[length(a)]           # last element = position
    sub("_"position"$", "", pos)      # strip trailing _position to get chrom
    if(pos=="NC_058072.1" && position+0>=20450110 && position+0<=20468842) print
}' | gzip > $DIR/hes1_LOC114955281.beagle.gz

pcangsd -b $DIR/hes1_LOC114955281.beagle.gz  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_hes1_LOC114955281_pca

#Second gene
zcat $DIR/Acropora_unlinked.beagle.gz | awk 'BEGIN{OFS="\t"} NR==1 { print; next } {
    pos = $1
    split(pos, a, "_")
    position = a[length(a)]           # last element = position
    sub("_"position"$", "", pos)      # strip trailing _position to get chrom
    if(pos=="NC_058072.1" && position+0>=20495840 && position+0<=20513836) print
}' | gzip > $DIR/hes1_LOC114955285.beagle.gz

pcangsd -b $DIR/hes1_LOC114955285.beagle.gz  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_hes1_LOC114955285_pca

#Noncoding region
zcat $DIR/Acropora_unlinked.beagle.gz | awk 'BEGIN{OFS="\t"} NR==1 { print; next } {
    pos = $1
    split(pos, a, "_")
    position = a[length(a)]           # last element = position
    sub("_"position"$", "", pos)      # strip trailing _position to get chrom
    if(pos=="NC_058072.1" && position+0>=20483176 && position+0<=20486793) print
}' | gzip > $DIR/hes1_noncoding2.beagle.gz

pcangsd -b $DIR/hes1_noncoding2.beagle.gz  --maf 0.01 --threads 16 --it 1000 --out $DIR/angsd_hes1_noncoding2_pca