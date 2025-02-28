
#!/bin/bash
# Chargement des modules nécessaires
module load bioinfo-cirad
module load bedtools/2.30.0

# Define input and output file paths as variables
INPUT_BED="scaled_low_tajima_urartu_filtered.bed"  # Input BED file
INPUT_GFF="Triticum_urartu.IGDB.59.chr.gff3"       # Input GFF file
OUTPUT_BED="intersected_high_tajima.bed"           # Output BED file

# Run bedtools intersect
bedtools intersect -wa -wb -a "$INPUT_BED" -b "$INPUT_GFF" > "$OUTPUT_BED"

# Print completion message
echo "Intersection complete. Results saved to $OUTPUT_BED."
