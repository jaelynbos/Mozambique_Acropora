#!/bin/bash
#SBATCH --job-name=sites_filt_all
#SBATCH -o sites_filt.out
#SBATCH --cpus-per-task=2
#SBATCH --mem=32G
#SBATCH --time=48:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

module load angsd/0.940

CONTIG_LIST=/home/jbos/Moz_scripts/chrom_list_Amillepora.txt
OUTDIR=/scratch/jbos/Moz_aligned_mil/invariant_sites

#POS_OUT=${OUTDIR}/pooled_all.pos.gz
#COUNTS_OUT=${OUTDIR}/pooled_all.counts.gz

#FIRST=1
#while read -r CONTIG; do
#    POS_FILE=${OUTDIR}/pooled.${CONTIG}.pos.gz
#    COUNTS_FILE=${OUTDIR}/pooled.${CONTIG}.counts.gz

    # skip any contig whose files are missing/empty (failed array tasks)
#    if [[ ! -s ${POS_FILE} || ! -s ${COUNTS_FILE} ]]; then
#        echo "WARNING: missing or empty output for ${CONTIG}, skipping" >&2
#        continue
#    fi

#    if [[ $FIRST -eq 1 ]]; then
        # keep header line from the first contig
#        cat ${POS_FILE} >> ${POS_OUT}
#        cat ${COUNTS_FILE} >> ${COUNTS_OUT}
#        FIRST=0
#    else
        # strip header line (first line) from every subsequent contig
#        zcat ${POS_FILE} | tail -n +2 | gzip >> ${POS_OUT}
#        zcat ${COUNTS_FILE} | tail -n +2 | gzip >> ${COUNTS_OUT}
#    fi
#done < ${CONTIG_LIST}

#echo "Done. Row counts (should match, plus 1 header):"
#zcat ${POS_OUT} | wc -l
#zcat ${COUNTS_OUT} | wc -l

SITES_OUT=/home/jbos/Moz_scripts/ANGSD_sites_invariant.txt

# Thresholds - adjust to your pooled N (331 individuals in your case)
#MININD=211          # 0.9*234
#MINDEPTH_TOTAL=1170 #5*234
#MAXDEPTH_TOTAL=35100 #150*234

# NF_POS = number of columns in .pos.gz
#NF_POS=3

#paste <(zcat ${POS_OUT} | tail -n +2) <(zcat ${COUNTS_OUT} | tail -n +2) | \
#awk -v mind=$MININD -v mindepth=$MINDEPTH_TOTAL -v maxdepth=$MAXDEPTH_TOTAL \
#    -v perind=$PERIND_MIN -v nfpos=$NF_POS '
#{
#    chr = $1; pos = $2; totdepth = $3;
#    if (totdepth < mindepth || totdepth > maxdepth) next;
#    nind = 0;
#    for (i = nfpos + 1; i <= NF; i++) {
#        if ($i >= perind) nind++;
#    }
#    if (nind >= mind) print chr"\t"pos;
#}' > ${SITES_OUT}

#echo "Sites retained:"
#wc -l ${SITES_OUT}

# ---- Index for ANGSD ----
angsd sites index $SITES_OUT