#!/bin/bash

# Files
contigs_bed="contigs.bed"
tajima_bed="low_tajima_urartu.bed"
output_bed="scaled_low_tajima_urartu.bed"

# Clear the output file before starting
> "$output_bed"

# Loop through each line of tajima_bed
while read -r line; do
    # Extract the contig name from the first column (for tajima_bed)
    contig_id=$(echo "$line" | awk '{print $1}')

    # Extract the interval start and end (columns 2 and 3)
    interval_start=$(echo "$line" | awk '{print $2}')
    interval_end=$(echo "$line" | awk '{print $3}')

    echo "Processing contig: $contig_id"
    echo "Interval start: $interval_start, Interval end: $interval_end"

    # Get the contig info from contigs.bed (searching for contig_id in the second column of contigs.bed)
    contig_info=$(grep -P -m 1 -w "$contig_id" "$contigs_bed")

    # Check if the contig exists in contigs.bed
    if [ -z "$contig_info" ]; then
        echo "Contig ID $contig_id not found in contigs.bed"
    else
        echo "Contig found in contigs.bed: $contig_info"

        # Extract the chromosome (first column), contig name (second column), and start position (third column) from contigs.bed
        chromosome=$(echo "$contig_info" | awk '{print $1}')
        contig_name=$(echo "$contig_info" | awk '{print $2}')
        contig_start=$(echo "$contig_info" | awk '{print $3}')
        echo "Chromosome: $chromosome, Contig name: $contig_name, Contig start position: $contig_start"

        # Calculate the new positions on the chromosome
        chrom_start=$((contig_start + interval_start))
        chrom_end=$((contig_start + interval_end))

        echo "Calculated chromosomal start: $chrom_start, chromosomal end: $chrom_end"

        # Output the scaled positions with chromosome, contig name, start, and end to the output file
        echo -e "$chromosome\t$contig_name\t$chrom_start\t$chrom_end" >> "$output_bed"
        echo "Outputting to $output_bed: $chromosome\t$contig_name\t$chrom_start\t$chrom_end"
    fi

done < "$tajima_bed"

###### delete la colonne en trop

cut -f1,3,4 scaled_low_tajima_urartu.bed > scaled_low_tajima_urartu_filtered.bed


echo "Script completed for all lines of $output_bed"


