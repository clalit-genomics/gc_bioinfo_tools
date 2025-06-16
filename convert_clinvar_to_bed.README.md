
A Bash script to extract selected fields from a gzipped VCF file and convert the output into a BED-like TSV format, including `ALLELEID` and `GENEINFO` annotations. It optionally filters for variants classified as (likely) pathogenic, excluding those with conflicting interpretations.

## 📄 Description

This script:

* Accepts a gzipped VCF file as input.
* Converts the VCF to BED format using `convert2bed`.
* Extracts key columns (columns 1–8) plus the `ALLELEID` and `GENEINFO` from the INFO field.
* Optionally filters variants to keep only those containing `"pathogenic"` in the `CLNSIG` annotation (case-insensitive) and excludes any with `"conflicting"` in the same field.

## 🚀 Usage

```{bash}
./convert_clinvar_to_bed.sh input.vcf.gz output.tsv [--only_plp]
```

### Arguments

| Argument       | Description                                                                                                           |
| -------------- | --------------------------------------------------------------------------------------------------------------------- |
| `input.vcf.gz` | Path to a gzipped VCF file.                                                                                           |
| `output.tsv`   | Path to output TSV file (tab-separated).                                                                              |
| `--only_plp`   | *(Optional)* If provided, only variants with `CLNSIG` containing `pathogenic` and not `conflicting` will be included. |

## ✅ Output Format

The output is a tab-separated file with the following 10 columns:

1. Chromosome
2. Start position
3. End position
4. Name
5. Score
6. Strand
7. ThickStart
8. ThickEnd
9. `ALLELEID` (extracted from INFO)
10. `GENEINFO` (extracted from INFO)

## 🔧 Requirements

* `convert2bed` (available via [BEDOPS](https://bedops.readthedocs.io/en/latest/content/installation.html))
* `zcat` (typically available on Unix/Linux)

## 🧪 Example

```{bash}
./process_vcf.sh ClinVar.vcf.gz output.tsv --only_plp
```

This will extract all variants with `pathogenic` in their `CLNSIG` field (excluding `conflicting`), and output the selected fields to `output.tsv`.

## 📌 Notes

* The script expects `CLNSIG`, `ALLELEID`, and `GENEINFO` to be present in the INFO field of the VCF.
* Filtering for `--only_plp` is case-insensitive and excludes any variant with conflicting evidence of pathogenicity.
