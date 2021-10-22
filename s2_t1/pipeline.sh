#!/bin/bash

fastqc $1.fastq
mv $1_fastqc.html $1.html
rm $1_fastqc.zip
minimap2 -d ref.mmi ref.fna
minimap2 -a ref.mmi $1.fastq > $1.sam
samtools flagstat $1.sam > $1_flagstat.txt

percent=$(grep -oP '\d+\.\d+(?=%)' $1_flagstat.txt | head -1 | tr -d .) # todo regex
if ((10#$percent > 9000)); then
   echo "OK"
else
   echo "not OK"
fi
