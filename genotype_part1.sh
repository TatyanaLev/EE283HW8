#!/bin/bash

#SBATCH --job-name=genotypeDNA-1
#SBATCH -A ecoevo283
#SBATCH -p standard                   ## standard partition
#SBATCH -N 1                          ## nodes
#SBATCH --array=1-4                   ## tasks
#SBATCH -c 2                          ## CPUs
#SBATCH -t 1-                         ## day run time limit

module load bcftools/1.10.2
module load java/1.8.0
module load gatk/4.1.9.0
module load picard-tools/1.87
module load bamtools/2.5.1        # bamtools merge is useful
module load freebayes/1.3.2       # fasta_generate_regions.py is useful
module load vcftools/0.1.16

##############################
## DO BEFORE RUNNING SCRIPT ##
##############################
#mkdir variant_calls
#cd variant_calls
#ls ../alignments/*RG.bam | sed 's/.RG.bam//' | cut -d "_" -f 1  > tmp.txt
#cat tmp.txt | uniq > bam_prefixes.txt
#rm tmp.txt

path="/data/class/ecoevo283/tzhuravl/RAWDATA/DNAseq/variant_calls"
file="bam_prefixes.txt"
ref="/data/class/ecoevo283/tzhuravl/RAWDATA/ref/dmel-all-chromosome-r6.13.fasta"
prefix=`head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1`
preprefix=`echo $prefix | cut -d "/" -f 3` 


cd $path

java -jar /opt/apps/picard-tools/1.87/MergeSamFiles.jar $(printf 'I=%s ' ${prefix}*.RG.bam) O=${preprefix}.merge.bam

/opt/apps/gatk/4.1.9.0/gatk MarkDuplicatesSpark -I ${preprefix}.merge.bam -O ${preprefix}.dedup.bam -M ${preprefix}.dedup.metrics.txt

/opt/apps/gatk/4.1.9.0/gatk HaplotypeCaller -R $ref -I ${preprefix}.dedup.bam --minimum-mapping-quality 30 -ERC GVCF -O ${preprefix}.g.vcf.gz
