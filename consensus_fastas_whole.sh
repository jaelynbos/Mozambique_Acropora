#!/bin/bash

#SBATCH --job-name=alignment
#SBATCH -o fasta_align-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=4
#SBATCH --mem=180G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
cd /scratch/jbos/Acropora_hyacinthus/consensus_fastas_whole

DIR=/scratch/jbos/Acropora_hyacinthus/consensus_fastas_whole
mkdir -p $DIR
cd $DIR

cp /home/jbos/ncbi/GCF_013753865.1_Amil_v2.1_genomic.fna $DIR/Amillepora_consensus.fasta

for file in *_consensus*.fa.gz ; do
    sample=$(basename "$file" ".fa.gz")
	gunzip -c $file > $sample.fasta
done

#gunzip -c isopora.fa.gz > isopora_consensus.fasta

#Get the list of contigs missing from isopora (relative to a full file, here DB)
comm -23 <(grep "^>" DB_consensus.fasta | sed 's/^>//' | sort) \
         <(grep "^>" isopora_consensus.fasta | sed 's/^>//' | sort) \
         > contigs_to_exclude.txt

wc -l contigs_to_exclude.txt   # should be 11
cat contigs_to_exclude.txt


# Remove contig that's missing from HC for some reason.
for f in *consensus.fasta; do
    awk '/^>NW_025323090.1/{skip=1; next} /^>/{skip=0} !skip' "$f" > tmp && mv tmp "$f"
done

#Remove contigs missing from isopora
for f in *consensus.fasta; do
    awk -v excl=contigs_to_exclude.txt '
        BEGIN {
            while ((getline line < excl) > 0) bad[line] = 1
        }
        /^>/ {
            id = substr($1, 2)   # strip leading ">"
            skip = (id in bad) ? 1 : 0
        }
        !skip
    ' "$f" > tmp && mv tmp "$f"
done

for file in *consensus.fasta; do
    sample=$(basename "$file" .consensus.fasta)
    echo ">$sample"
    awk '/^>/ {next} {printf "%s", $0} END {print ""}' "$file"
done > Acropora_aligned.fasta

awk '/^>/{if(name) print name, length(seq); name=$0; seq=""; next} {seq=seq $0} END{print name, length(seq)}' Acropora_aligned.fasta

awk '
/^>/ {
    if (seq != "") print_seq()
    header = $0
    seq = ""
    next
}
{ seq = seq $0 }
END { if (seq != "") print_seq() }
function print_seq() {
    print header
    out = ""
    for (i = 100; i <= length(seq); i += 100) out = out substr(seq, i, 1)
    print out
}
' Acropora_aligned.fasta > Acropora_aligned_small.fasta