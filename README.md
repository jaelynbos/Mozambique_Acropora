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
MatPlotLib Python library version 3.10.8 https://matplotlib.org/ \
GGmap R package version 4.0.1 https://github.com/dkahle/ggmap \
APE R package version 5.8 https://emmanuelparadis.github.io/ \
R version 4.3.3 \
Python version 3.9.25 

## Bioinformatic pre-processing
### Pre-processing _Acropora_ samples from Mozambique. 
Reads from Mozambique are de-multiplexed and merged across lanes. Bioinformatic processing should be conducted using the following scripts in order:
1.1 First trim using trim_funcs.sh. Requires: Fastp, Parallel, and Multiqc. \
1.2 Deduplicate using clump_batch2.bash to run clumpify2.sh. Requires: Clumpify (from BBtools). \
1.3 Second trim using trim_funcs2.sh. Requires: Fastp, Parallel, and Multiqc. \
1.4 Re-pair unpaired reads using repair_2.sh. Requires: BBtools. \
1.5 Map genes to _Acropora_millepora_ reference using bwa_array.bash to run bwa_amillepora.sh. Requires: BWA. \
1.6 Sort and index SAMfiles and convert to BAMfiles with samtools_loop.sh Requires: SAMtools. \
1.7 Measure sequencing depth across sites for each individual, as well as mean and median depth across all individuals with samtools_depth.sh. Requires: SAMtools and GNU Datamash. \

### Pre-processing _Acropora_ samples from American Samoa. 
Reads dowloaded from NCBI are de-multiplexed and merged across lanes. Bioinformatic processing should be conducted using the following scripts in order, all found in the /Acropora_hyacinthus_pipeline folder: \
1.8 First trim using trim_funcs_Ahyacinthus.sh. Requires: Fastp, Parallel, and Multiqc. \
1.9 Deduplicate using clumpify_Ahyacinthus.sh. Requires: Clumpify (from BBtools). \
1.10 Second trim using trim_funcs2_Ahyacinthus.sh. Requires: Fastp, Parallel, and Multiqc. \
1.11 Re-pair unpaired reads using repair_Ahyacinthus.sh. Requires: BBtools. \
1.12 Map genes to _Acropora_millepora_ reference using bwa_amillepora_Ahyacinthus.sh. Requires: BWA. 

### Pre-processing _Isopora_ outgroup.
Bioinformatic processing should be conducted using the following scripts in order, all found in the /isopora_pipeline folder: \
1.13 First trim using trim_funcs_isopora.sh. Requires: Fastp, Parallel, and Multiqc. \
1.14 Deduplicate using clumpify_isopora.sh. Requires: Clumpify (from BBtools). \
1.15 Second trim using trim_funcs2_isopora.sh. Requires: Fastp, Parallel, and Multiqc. \
1.16 Re-pair unpaired reads using repair_isopora.sh. Requires: BBtools. \
1.17 Map genes to _Acropora_millepora_ reference using bwa_amillepora_isopora.sh. Requires: BWA. 

## Analysis of _Acropora_ samples from Mozambique

### Sorting out bad field IDs
I was pretty bad at sample collection at the beginning of this project. Steps 2.1 through 2.XX sort out my bad field IDs of highly diverged _Acropora_ \
2.1 Call SNPs from Mozambique data with ANGSD1.sh. Requires: ANGSD. \
2.2 Concatenate *.beagle files across contigs with angsd_concat.sh \
2.3 Select every 1000th SNP with SNP_subset_lazy.sh. \ 
2.4 Run PCA and ADMIXTURE with pcangsd1.sh. Requires: PCAngsd.\
2.5 Plot PCs and ADMIXTURE groups and make lists of BAMfile for each group with Acropora_Moz_1stPCA.ipynb. Runs on R kernel. \
2.6 Make list of SNPs included in beagle with make_snplist1.sh \
2.7 Make SAFs for each ancestry group with angsd_safs.sh. Requires: ANGSD \
2.8 Make SFS for each ancestry group with sfs.sh. Requires: ANGSD \
2.9 Calculate FSTs between ancestry groups wiht fst_from_saf.sh. Requires: ANGSD \

### SNP calling, PCA, and clones for focal species.
After excluding those samples belonging to highly diverged _Acropora_, I proceeded with analysis for the ancestry groups corresponding to our focal species (the majority of the samples). \
2.10 Call SNPs from focal species with ANGSD2.sh. Requires: ANGSD. \
2.11 Concatenate *.beagle files across contigs with angsd_concat2.sh \
2.12 Calculate linkage between SNPs with ngsLD_prunegraph.sh. Requires: NGSLD and PruneGraph \
2.13 Remove linked SNPs from beagle file with unlink_beagle.sh \
2.14 Run PCA and ADMIXTURE with pcangsd2.sh. Requires: PCAngsd. \
2.15 Create .glf files for relatedness analysis with angsd_GLFs.sh. Requires: ANGSD. |
2.16 Calculate relatedness coefficients with ngsrelate.sh. Requires: NGSRelate.\
2.17 Identify clones with Acropora_moz_relatedness.ipynb. Runs on R kernel. \
2.18 Exclude clones, identify ancestry groups, test for environmental differences between species, create inputs for GWAS, and make Fig. 2 with Acropora_Moz_2ndPCA.ipynb. Runs on R kernel. \ 
2.19 Make new list of SNPs with make_snplist2.sh 

### Windowed FST analysis. 
2.20 Create new .saf files for calculating FSTs with angsd_safs2.sh. Requires: ANGSD. \
2.21 Concatenate .saf files and create .sfs files with sfs2.sh. Requires: ANGSD. \
2.22 Calculate average FSTs between groups with average_fsts.sh. Requires: ANGSD. \
2.23 Calculate windowed FSTs between groups with windowed_fst.sh. Requires: ANGSD. \
2.24 Make Fig. 3 and Supplemental Fig. 2 with Acropora_moz_fig3.ipynb. Runs on R kernel. 

### Genetic variability and selective sweeps(?) at HES-1 locus.
2.25 Create .safs including invariant sites with angsd_safs_allSNPs.sh. Requires: ANGSD. \
2.26 Concatenate .saf files and create .sfs files with sfs_allSNPs.sh. Requires: ANGSD. \
2.27 Calculate π, Watterson's θ, and Tajima's D with thetas.sh. Requires: ANGSD. \
2.28 Calculate π, Watterson's θ, and Tajima's D with thetastat.sh. Requires: ANGSD. \
2.29 Calculate linkage disequilibrium at the HES-1 locus wiht hes1_ld.sh. Requires: NGSLD. \
2.30 Create .beagle files for each population (DB, DA_North, DA_South) separately with ANGSD_beagle_by_group.sh. Requires: ANGSD. \
2.31 Concatenate *.beagle files across contigs with angsd_concat3.sh \
2.32 Calculate genome-wide LD by species with ngsld_spp.sh. Requires: NGSLD. 

### GWAS with bleaching.
This didn't really work out. \
2.33 Run GWAS with GWAS.sh. Requires: ANGSD. \
2.34 Concatenate across contigs with gwas_concat.sh \
2.35 Visualize output with GWAS.ipynb. Runs on R kernel. \
2.36 Look at other bleaching statistics with Acropora_moz_bleaching.ipynb. Runs on R kernel. 

### Temperature logger figures.
2.37 Make Fig. 1 (sampling map) with Mozambique_map.R \
2.38 Make Supplemental Table 1 and Supplemental Fig. 1 with Acropora_moz_TempLoggers.ipynb. Runs on Python kernel.

## Comparison with _Acropora_ samples from American Samoa

# SNP calling and linkage filter
3.1 Call SNPs for Mozambique and American Samoa samples together with joint_ANGSD.sh. Requires: ANGSD. \
3.2 Concatenate *.beagle files across contigs with angsd_joint_concat.sh \
3.3 Calculate linkage between SNPs with ngsLD_prunegraph_joint.sh. Requires: NGSLD and PruneGraph \
3.4 Remove linked SNPs from beagle file with unlink_beagle_joint.sh \
3.5 Make list of SNPs with make_snplist3.sh \
3.6 Run PCA and ADMIXTURE with joint_PCANGSD.sh. Requires: PCAngsd.

# Making consensus .FASTA files
3.7 Make consensus FASTA files for samples from American Samoa with fasta_consensus_Ahyacinthus.sh. Requires: BWA \ 
3.8 Make consensus FASTA file for DB with fasta_consensus_DB.sh. Requires: BWA \ 
3.9 Make consensus FASTA file for DA_North with fasta_consensus_DA_North.sh. Requires: BWA \ 
3.10 Make consensus FASTA file for DA_South with fasta_consensus_DA_South.sh. Requires: BWA \ 

# Phylogenetic trees
3.11 Align first gene from each chromosome across samples with mafft_bychrom.sh. Requires: SAMtools and MAFFT. \
3.12 Make phylogenetic trees for first gene on each chromosome and create Supplemental Fig 3 with Acropora_moz_supplemental_fig3.ipynb. Runs on R kernel. \
3.13 Align genes within HES-1 using mafft_nucleotide.sh. Requires: SAMtools and MAFFT. \
3.14 Plot PCAs and gene trees across species using Acropora_moz_fig5.ipynb. Runs on R kernel. 

# ABBA-BABA testing
3.15 Do some ABBA-BABA testing of lineages from Mozambique and American Samoa using angsd_abbababa.sh. Requires: ANGSD \
3.16 Unpack results badly using abbababa.ipynb. Runs on R kernel
