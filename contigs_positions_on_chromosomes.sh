#!/bin/bash

## obtain positions of the contigs on chromosomes
###############

awk '$3 == "mRNA" { 
    match($9, /ID=transcript:([^;]+)/, id); 
    print $1, id[1], $4, $5 
}' OFS="\t" Triticum_urartu.IGDB.59.chr.gff3 > contigs.bed

awk '$3 == "mRNA" { 
    match($9, /ID=([^;]+)/, id); 
    print $1, id[1], $4, $5 
}' OFS="\t" YANG_2023_Y2032.updata.gff3 > contigs.bed

