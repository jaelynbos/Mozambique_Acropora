#!/bin/bash

#SBATCH --job-name=ngsrelate
#SBATCH -o ngsrelate-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=500G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load miniconda3
conda activate ngsrelate

DIR=/scratch/jbos/Moz_aligned_mil/glf_grp137

first=1
for f in ${DIR}/Acropora_moz.N*.mafs.gz; do
    if [ $first -eq 1 ]; then
        zcat $f
        first=0
    else
        zcat $f | tail -n +2  # skip header line for all subsequent files
    fi
done | bgzip > ${DIR}/Acropora_moz_all.mafs.gz

for f in ${DIR}/Acropora_moz.N*.glf.gz; do
    zcat $f
done | bgzip > ${DIR}/Acropora_moz_all.glf.gz

#Normally should be f6 but mafs file has an extra column ('anc') because I created the glf at the same time as the saf
zcat $DIR/Acropora_moz_all.mafs.gz | cut -f 6 | sed 1d > $DIR/freq 

ngsRelate -g $DIR/Acropora_moz_all.glf.gz -n 236 -p 16 -f $DIR/freq -r 42 -O $DIR/newres