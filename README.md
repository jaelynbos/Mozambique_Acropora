# Mozambique _Acropora_ multi scale genetic variation
This repo uses Illumina short read whole genome sequences from samples of _Acropora aff. divaricata_ corals to examine spatial genetic variation and genetic variation associated with climate at multiple spatial scales.
It also compares sequences from Mozambique with sequences of _Acropora aff. hyacinthus_ collected in American Samoa. 

All code is associated with the mansucript _Shared genetic variation genetic across ocean basins around a heat tolerance locus in_ Acropora (in prep). 

The README is organized into four sections: \
A) Data sources \
B) Required software \
C) Bioninformatic pre-processing for all samples \
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
GNU Parallel version 20200122. https://www.gnu.org/software/parallel/ \
BBtools version 39.06. https://archive.jgi.doe.gov/data-and-tools/software-tools/bbtools/ \
BWA-mem version  0.7.17. https://bio-bwa.sourceforge.net/ \
SAMtools version 1.20. https://github.com/samtools/samtools \
GNU Datamash version 1.9. https://www.gnu.org/software/datamash/ \
ANGSD version 0.940 https://www.popgen.dk/angsd/index.php/ANGSD \
NGSLD version 1.20 https://github.com/fgvieira/ngsLD \
PruneGraph version 0.4.0 https://github.com/fgvieira/prune_graph \
NGSrelate version 2.0 https://github.com/angsd/ngsrelate \
PCAngsd version 1.36.1 https://www.popgen.dk/software/index.php/PCAngsd \
MAFFT version 7.526 https://mafft.cbrc.jp/alignment/software/ \
APE R package version 5.8 https://emmanuelparadis.github.io/ \
R version 4.3.3 \
Python version 3.9.25 

## Bioinformatic pre-processing
# Pre-processing _Acropora_ samples from Mozambique. 
Reads from Mozambique are de-multiplexed and merged across lanes. Bioinformatic processing should be conducted using the following scripts in order:

1.1 First trim using trim_funcs.sh. Requires: Fastp, Parallel, and Multiqc. \
1.2 Deduplicate using clump_batch2.bash to run clumpify2.sh. Requires: Clumpify (from BBtools). \
1.3 Second trim using trim_funcs2.sh. Requires: Fastp, Parallel, and Multiqc. \
1.4 Re-pair unpaired reads using repair_2.sh. Requires: BBtools. \
1.5 Map genes to _Acropora_millepora_ reference using bwa_array.bash to run bwa_amillepora.sh. Requires: BWA. \
1.6 Sort and index SAMfiles and convert to BAMfiles with samtools_loop.sh Requires: SAMtools. \
1.7 Measure sequencing depth across sites for each individual, as well as mean and median depth across all individuals with samtools_depth.sh. Requires: SAMtools and GNU Datamash. \

# Pre-processing _Acropora_ samples from American Samoa. 
Reads dowloaded from NCBI are de-multiplexed and merged across lanes. Bioinformatic processing should be conducted using the following scripts in order, all found in the /Acropora_hyacinthus_pipeline folder: \

1.8 First trim using trim_funcs_Ahyacinthus.sh. Requires: Fastp, Parallel, and Multiqc. \
1.9 Deduplicate using clumpify_Ahyacinthus.sh. Requires: Clumpify (from BBtools). \
1.10 Second trim using trim_funcs2_Ahyacinthus.sh. Requires: Fastp, Parallel, and Multiqc. \
1.11 Re-pair unpaired reads using repair_Ahyacinthus.sh. Requires: BBtools. \
1.12 Map genes to _Acropora_millepora_ reference using bwa_amillepora_Ahyacinthus.sh. Requires: BWA. \

# Pre-processing _Isopora_ outgroup.
Bioinformatic processing should be conducted using the following scripts in order, all found in the /isopora_pipeline folder: \
1.13 First trim using trim_funcs_isopora.sh. Requires: Fastp, Parallel, and Multiqc. \
1.14 Deduplicate using clumpify_isopora.sh. Requires: Clumpify (from BBtools). \
1.15 Second trim using trim_funcs2_isopora.sh. Requires: Fastp, Parallel, and Multiqc. \
1.16 Re-pair unpaired reads using repair_isopora.sh. Requires: BBtools. \
1.17 Map genes to _Acropora_millepora_ reference using bwa_amillepora_isopora.sh. Requires: BWA. \





1.18 Call SNPs with ANGSD1.sh. Requires: ANGSD.
1.19 Concatenate *.beagle files across contigs with angsd_concat.sh. 

