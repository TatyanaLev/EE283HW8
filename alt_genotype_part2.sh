#!/bin/bash

#SBATCH --job-name=genotypeDNA-2
#SBATCH -A ecoevo283
#SBATCH -p standard                   ## standard partition
#SBATCH -N 1                          ## nodes
#SBATCH --array=17                    ## tasks - array not needed
#SBATCH -c 2                          ## CPUs
#SBATCH -t 1-                         ## day run time limit

module load java/1.8.0
module load gatk/4.1.9.0
module load picard-tools/1.87
module load bamtools/2.5.1        # bamtools merge is useful
module load freebayes/1.3.2       # fasta_generate_regions.py is useful
module load vcftools/0.1.16

##############################
## DO BEFORE RUNNING SCRIPT ##
##############################
#sbatch genotype_part1.sh
#python3 fasta_generate_regions.py $ref 10000000 > DNA_regions_4Mb.txt

path="/data/class/ecoevo283/tzhuravl/RAWDATA/DNAseq/variant_calls"
ref="/data/class/ecoevo283/tzhuravl/RAWDATA/ref/dmel-all-chromosome-r6.13.fasta"
interval=`head -n $SLURM_ARRAY_TASK_ID DNA_regions_4Mb.txt | tail -n 1`

cd $path

/opt/apps/gatk/4.1.9.0/gatk GenotypeGVCFs -R $ref -V allsample.g.vcf.gz --intervals $interval -stand-call-conf 5 -O SNPbyregion/$interval.vcf.gz

/opt/apps/gatk/4.1.9.0/gatk GenotypeGVCFs -R $ref -V allsample.g.vcf.gz -stand-call-conf 5 -O genotypes_result.vcf.gz
