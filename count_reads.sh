#!/bin/bash

#SBATCH --job-name=countReads
#SBATCH -A ecoevo283                  ## account to charge
#SBATCH -p standard                   ## standard partition
#SBATCH -N 1                          ## nodes
##SBATCH --array=1                    ## tasks - no array this time
#SBATCH -c 5                          ## CPUs
#SBATCH -t 1-                         ## day run time limit

module load subread/2.0.1

##############################
## DO BEFORE RUNNING SCRIPT ##
##############################
#mkdir analysis

ref="/data/class/ecoevo283/tzhuravl/RAWDATA/ref/dmel-all-chromosome-r6.13.fasta"
gtf="/data/class/ecoevo283/tzhuravl/RAWDATA/ref/dmel-all-r6.13.gtf"
file="/data/class/ecoevo283/tzhuravl/RAWDATA/RNAseq/analysis/RNA_bams_list.txt"

path="/data/class/ecoevo283/tzhuravl/RAWDATA/RNAseq/analysis"

cd $path

bams=`cat $file | tr "\n" " "`
featureCounts -p -T 5 -t exon -g gene_id -Q 30 -F GTF -a $gtf -o fly_counts_2.txt $bams
