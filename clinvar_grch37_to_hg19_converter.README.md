# `clinvar_grch37_to_hg19_converter.sh`

A Bash script to convert chromosome names in a VCF file to the UCSC-style `hg19` notation (e.g., `1` → `chr1`, `MT` → `chrM`). It handles both plain-text and gzipped VCF files and preserves VCF headers.

## 📄 Description

This script:

* Accepts a `.vcf` or `.vcf.gz` file.
* Adds the `"chr"` prefix to chromosome names if missing.
* Converts `"MT"` to `"chrM"` to match `hg19` naming conventions.
* Skips any lines that do not begin with a recognizable chromosome name (1–22, X, Y, or MT).
* Preserves all header lines (`##` and `#CHROM`).

## 🚀 Usage

```{bash}
./hg19_prefix_converter.sh <input_file>
```

### Arguments

| Argument       | Description                        |
| -------------- | ---------------------------------- |
| `<input_file>` | Path to a `.vcf` or `.vcf.gz` file |

### Output

* A new file will be created in the same directory, named `hg19_<original_filename>`, with the corrected chromosome naming.

## ✅ Example

```{bash}
./hg19_prefix_converter.sh variants.vcf.gz
```

Will produce a file named:

```
hg19_variants.vcf
```

## 🔧 Requirements

* Standard Unix/Linux environment
* `zcat` (for reading gzipped files)

## 📝 Output Logic

| Input Chrom | Output Chrom |
| ----------- | ------------ |
| `1`         | `chr1`       |
| `X`         | `chrX`       |
| `MT`        | `chrM`       |
| `chr2`      | `chr2`       |
| (other)     | skipped      |

All header lines (lines starting with `##` or `#CHROM`) are preserved as-is.

## 📌 Notes

* Lines not matching the expected chromosome pattern are ignored.
* The script strips `.gz` from the output filename, if present.
* Output is written to the same directory where the script is run.

