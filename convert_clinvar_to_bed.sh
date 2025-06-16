#!/bin/bash

# Usage: ./process_vcf.sh input.vcf.gz output.tsv [--only_plp]

input_vcf_gz="$1"
output_tsv="$2"
only_plp="$3"

convert2bed -i vcf < <(zcat "$input_vcf_gz") |

awk -F'\t' -v filter="$only_plp" '
{
    keep = 1
    if (filter == "--only_plp") {
        keep = 0
        split($9, info, ";")
        for (i in info) {
            if (info[i] ~ /^CLNSIG=/) {
                clnsig_val = tolower(info[i])
                if (clnsig_val ~ /pathogenic/ && clnsig_val !~ /conflicting/) {
                    keep = 1
                }
                break
            }
        }
    }
    if (keep) {
        split($9, info, ";");
        alleleid = ""; geneinfo = "";
        for (i in info) {
            if (info[i] ~ /^ALLELEID=/) {
                split(info[i], tmp, "="); alleleid = tmp[2];
            } else if (info[i] ~ /^GENEINFO=/) {
                split(info[i], tmp, "="); geneinfo = tmp[2];
            }
        }
        print $1, $2, $3, $4, $5, $6, $7, $8, alleleid, geneinfo;
    }
}' OFS='\t' > "$output_tsv"
