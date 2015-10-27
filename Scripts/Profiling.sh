#!/usr/bin/env bash
echo "Step 1:"
echo "Aligning fully filtered reads to NCBI bacteria compelete genomes with Bowtie2"
BOWTIE2 -p ${CPU} --local -D 20 -R 3 -N 1 -L 32 -i S,1,0.50 -x ${BACTERIA} -f ${WORKDIR}/${SAMPLE}_Filter_S5.fasta -S ${WORKDIR}/${SAMPLE}_profiling.sam
echo "Step 2:"
echo "Calculating the genome coverages"
mkdir ${WORKDIR}/temp
samtools view -S -F4 ${WORKDIR}/${SAMPLE}_profiling.sam >> mappedReads.sam
cat "list.txt" | while read line; do 
    count=$(grep -v "XS" mappedReads.sam | grep -c $line)
    if [ $count -gt $MINCOUNTS ]; then
    	grep mappedReads.sam | grep -v "XS" > temp.sam
    	genomeLength=$(grep $line header.sam | awk '{print substr($3, 4)}')
			cat header.sam temp.sam > temp1.sam
			samtools view -S -b  temp1.sam -o temp1.bam
			samtools sort temp1.bam temp2
			samtools index temp2.bam
			samtools view temp2.bam -o ${WORKDIR}/temp/${line}.sam
			Rscript calVar.R ${WORKDIR}/temp/${line}.sam $genomeLength 5000			
    	rm temp.sam
    	rm temp1.sam
    	rm temp1.bam
    	rm temp2.bam
    	rm temp2.bam.bai
    fi
done
rm -r ${WORKDIR}/temp
echo "Step 3:"
echo "Assigning the multiple mapped the reads with PathoScope"
python $PATHOSCOPE ID -alignFile ${WORKDIR}/${SAMPLE}_profiling.sam -expTag ${SAMPLE} -outDir ${WORKDIR}
echo "Step 4:"
echo "Re-evaluating the relative abundances of microbiome"


