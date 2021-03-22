# Genotyping DNA

Variants (deviations from the reference) are pulled out from alignment maps from last week and made into easier to use table in the "variant calls format" -- VCF. 



The first [script1](https://github.com/TatyanaLev/EE283HW8/blob/main/genotype_part1.sh) merges and marks duplicates in replicate samples, and does the variant calling once for each merged sample using GATK HaplotypeCaller.
 
The second [script2](https://github.com/TatyanaLev/EE283HW8/blob/main/genotype_part2.sh) combines all merged samples into one table. The first script is submitted as an array, with a seperate task for each sample. The second script is just one task that genotypes the one master VCF.
 
[Alternative script2](https://github.com/TatyanaLev/EE283HW8/blob/main/alt_genotype_part2.sh) for part 2 is just a way to split up the genopyting process by making several intervals. A [python script](https://github.com/TatyanaLev/EE283HW8/blob/main/fasta_generate_regions.py) makes the intervals

Results:

```{bash}
(base) [tzhuravl@login-i17:/data/class/ecoevo283/tzhuravl/RAWDATA/DNAseq/variant_calls] $ls -lah | tail
-rw-r--r-- 1 tzhuravl class-ecoevo283-ta 359K Mar 10 13:42 ADL14.dedup.bam.sbi
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 3.1K Mar 10 12:58 ADL14.dedup.metrics.txt
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 574M Mar 10 17:14 ADL14.g.vcf.gz
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 247K Mar 10 17:14 ADL14.g.vcf.gz.tbi
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 7.9G Mar 10 12:08 ADL14.merge.bam
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 1.5G Mar 11 03:13 allsample.g.vcf.gz
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 239K Mar 11 03:13 allsample.g.vcf.gz.tbi
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta   80 Mar 10 11:08 DNA_bam_prefixes.txt
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 134M Mar 11 03:27 genotypes_result.vcf.gz
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 134K Mar 11 03:27 genotypes_result.vcf.gz.tbi
```

# Counting RNA reads

The [count_reads script](https://github.com/TatyanaLev/EE283HW8/blob/main/count_reads.sh) makes a genes by samples matrix from individual alignment files from last week.

Results:

```{bash}
(base) [tzhuravl@login-i17:/data/class/ecoevo283/tzhuravl/RAWDATA/RNAseq/analysis] $ls -lah
total 5.4M
drwxrwsr-x 2 tzhuravl class-ecoevo283-ta    5 Mar 21 13:24 .
drwxrwsr-x 4 tzhuravl class-ecoevo283-ta  761 Mar 10 11:58 ..
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 5.0M Mar 10 12:31 fly_counts_2.txt
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta 2.1K Mar 10 12:31 fly_counts_2.txt.summary
-rw-rw-r-- 1 tzhuravl class-ecoevo283-ta  660 Mar 10 11:57 RNA_bams_list.txt
```
