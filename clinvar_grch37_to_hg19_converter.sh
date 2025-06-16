#!/bin/bash

# Check if the input file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"
output_file="hg19_${input_file%.gz}"  # Strip .gz if present

# Determine how to read the input (gzip or plain text)
if [[ "$input_file" == *.gz ]]; then
    read_cmd="zcat"
else
    read_cmd="cat"
fi

# Process the file
$read_cmd "$input_file" | while IFS= read -r line || [[ -n "$line" ]]; do
    # Check if the line is a header or the column definition line
    if [[ "$line" == \##* ]] || [[ "$line" == \#CHROM* ]]; then
        echo "$line" >> "$output_file"
    elif [[ "$line" =~ ^MT ]]; then
        echo "chrM${line:2}" >> "$output_file"
    elif [[ "$line" =~ ^[0-9XY] || "$line" =~ ^chr[0-9XY] ]]; then
        if [[ "$line" =~ ^chr ]]; then
            echo "$line" >> "$output_file"
        else
            echo "chr$line" >> "$output_file"
        fi
    fi
done

echo "Processing complete. Output saved to $output_file"
