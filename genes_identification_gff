#!/bin/bash

# Define input and output file paths as variables
INPUT_BED="intersected_high_tajima.bed"  # Input BED file
OUTPUT_FILE="genes_identification"       # Output file

# Extract gene information from the BED file
grep "description" "$INPUT_BED" | awk -F "\t|;" '{
    gene_id=""; description="";
    start=$2; end=$3;
    for(i=1; i<=NF; i++) {
        if($i ~ /ID=gene:/) {
            split($i, a, ":");
            gene_id=a[2];
        }
        if($i ~ /description=/) {
            split($i, b, "=");
            description=b[2];
        }
    }
    if(gene_id!="" && description!="") {
        print gene_id "\t" start "\t" end "\t" description;
    }
}' OFS="\t" > "$OUTPUT_FILE"

# Print completion message
echo "Gene information extracted. Results saved to $OUTPUT_FILE."
