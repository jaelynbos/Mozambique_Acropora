#!/bin/bash -l

#SBATCH --job-name=clmp_r12
#SBATCH -o clmp_r1r2_%A_%a.out
#SBATCH -c 12
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=500G
#SBATCH --array=0-1%1

module load java
module load parallel
module load miniconda3
conda activate clump

FQPATTERN="*.r1.fq.gz"
INDIR=/scratch/jbos/isopora/trim1
OUTDIR=/scratch/jbos/isopora/clump
TEMPDIR=/scratch/jbos/isopora/temp

THREADS=2   #clumpify uses a ton of ram, be conservative
GROUPS=auto
RAMPERTHREAD=200g   #have had to set as high as 233g with groups=1

ulimit -n 40960 

all_samples=($(basename -a $INDIR/$FQPATTERN | \
	sed 's/\.r1\.fq\.gz$//'))
all_samples=($all_samples)

sample_name=${all_samples[${SLURM_ARRAY_TASK_ID}]}
echo ${sample_name}

clumpify.sh \
	in=$INDIR/${sample_name}.r1.fq.gz \
	in2=$INDIR/${sample_name}.r2.fq.gz \
	out=$OUTDIR/${sample_name}.clmp.r1.fq.gz \
	out2=$OUTDIR/${sample_name}.clmp.r2.fq.gz \
	groups=auto \
	overwrite=t \
	usetmpdir=t \
	lowcomplexity=t \
	tmpdir=$TEMPDIR \
	deletetemp=t \
	dedupe=t \
	addcount=t \
	subs=2 \
	containment=t \
	consensus=f \
	-Xmx$RAMPERTHREAD
