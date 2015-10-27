#!/usr/bin/env bash
export PATH=/home/user/tools/samtools-0.1.18:/home/user/tools/RepeatMasker:/home/user/tools/blast-2.2.27/bin/:/home/user/tools/R-3.0.2/bin/:$PATH

BWA=/home/user/tools/bwa-0.6.2/bwa
BOWTIE2=/home/user/tools/bowtie2-2.2.5/bowtie2
PATHOSCOPE=/home/user/tools/pathoscope2/pathoscope/pathoscope.py

HUMANHG19=/home/user/genomes/human_hg19
HUMANOTHER=/home/user/genomes/human_additional
BACTERIA=/home/user/genomes/bacteria_bowtie2

WORKDIR=/home/user/workingFolder
SAMPLE=samplename
CPU=16
MINCOUNTS=50