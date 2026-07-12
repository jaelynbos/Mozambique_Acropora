#!/bin/bash -l

#SBATCH --job-name=clmp_r12
#SBATCH -o clmp_r1r2_-%A_%a.out
#SBATCH --array=0-114%2
#SBATCH -c 12
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=800G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

FQPATTERN=*r1.fq.gz
INDIR=/scratch/jbos/Acropora_hyacinthus/trim1
OUTDIR=/scratch/jbos/Acropora_hyacinthus/clump
TEMPDIR=/scratch/jbos/Acropora_hyacinthus/temp

THREADS=2   #clumpify uses a ton of ram, be conservative
RAMPERTHREAD=380g   #have had to set as high as 233g with groups=1

ulimit -n 40960 

mkdir -p $TEMPDIR

all_samples=$(ls $INDIR/$FQPATTERN | \
	sed -e 's/r1\.fq\.gz//' -e 's/.*\///g')
all_samples=($all_samples)

echo "Task ID: ${SLURM_ARRAY_TASK_ID}"
echo "Sample name: ${sample_name}"
echo "Input R1: $INDIR/${sample_name}r1.fq.gz"
echo "Input R2: $INDIR/${sample_name}r2.fq.gz"
ls -la $INDIR/${sample_name}r1.fq.gz
ls -la $INDIR/${sample_name}r2.fq.gz

sample_name=${all_samples[${SLURM_ARRAY_TASK_ID}]}
echo ${sample_name}

clumpify.sh \
	in=$INDIR/${sample_name}r1.fq.gz \
	in2=$INDIR/${sample_name}r2.fq.gz \
	out=$OUTDIR/${sample_name}clmp.r1.fq.gz \
	out2=$OUTDIR/${sample_name}clmp.r2.fq.gz \
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
