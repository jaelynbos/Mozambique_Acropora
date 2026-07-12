# Mozambique _Acropora_ multi scale genetic variation
This repo uses Illumina short read whole genome sequences from samples of _Acropora aff. divaricata_ corals to examine spatial genetic variation and genetic variation associated with climate at multiple spatial scales.
It also compares sequences from Mozambique with sequences of _Acropora aff. hyacinthus_ collected in American Samoa. 

All code is associated with the mansucript _Shared genetic variation genetic across ocean basins around a heat tolerance locus in_ Acropora (in prep). 

The README is organized into four sections: \
A) Data sources \
B) Required software \
C) Bioninformatic pre-processing \
D) Analysis of _Acropora_ samples from Mozambique \
E) Comparison with _Acropora_ samples from American Samoa

All pre-processing, mapping, and  analysis was run on the University of California's high performance computing cluster 'Elkhorn' (https://its.ucsc.edu/services/research-computing/research-specific-computing-and-applications/elkhorn-high-performance-computing-cluster/)

## Data availability
Reads from Mozambique are not publicly available at this time, pending publication and approval from the Mozambican government.\
The _Acropora millepora_ reference genome was downloaded from NCBI, at https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_013753865.1/, GenBank assembly GCA_013753865.1 \
_Acropora aff. hyacinthus_ reads from American Samoa were downloaded from NCBI, at https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA657822, SRA accession PRJNA657822 \
The _Isopora aff. cuneata_ genome used for outgroup comparison in ABBA-BABA testing was downloaded from NCBI, at https://www.ncbi.nlm.nih.gov/sra/ERX16119961[accn], sample accession SAMEA110183978.

Metadata will be made available upon publication.

## Required software
Fastp version 0.23.4. https://github.com/opengene/fastp \
Multiqc version 1.27. https://seqera.io/multiqc/  \
Parallel version 20200122. https://www.gnu.org/software/parallel/ \
BBtools version 39.06. https://archive.jgi.doe.gov/data-and-tools/software-tools/bbtools/ \
BWA-mem version  0.7.17. https://bio-bwa.sourceforge.net/ \
SAMtools version 1.20. https://github.com/samtools/samtools \
ANGSD version 0.940 https://www.popgen.dk/angsd/index.php/ANGSD \
NGSLD version 1.20 https://github.com/fgvieira/ngsLD \
PruneGraph version 0.4.0 https://github.com/fgvieira/prune_graph \
NGSrelate version 2.0 https://github.com/angsd/ngsrelate \
PCAngsd version 1.36.1 https://www.popgen.dk/software/index.php/PCAngsd \
MAFFT version 7.526 https://mafft.cbrc.jp/alignment/software/ \
APE R package version 5.8 https://emmanuelparadis.github.io/ \
R version 4.3.3 \
Python version 3.9.25 



