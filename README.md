# MAKING_TREES
# WORKFLOW FOR MAKING GENE AND SPECIES TREES FOR COMPARATIVE PHYLOGENETIC ANALYSIS
This repository contains scripts for generating gene a species tree and gene trees for phylogenetic analyses 

The scripts are written in bash and R for a slurm based computing cluster like this one: https://documentation.sigma2.no/jobs/job_scripts/saga_job_scripts.html

# PART 1. MAKING ALIGNMENTS FROM ORTHOGROUPS
#################################################################################### <br />

I use the following programs for making trees: <br />
[ORTHOFINDER](https://github.com/davidemms/OrthoFinder) <br />
[pal2nal](http://www.bork.embl.de/pal2nal/) <br />
[MrModeltest](https://github.com/nylander/MrModeltest2) <br />
[PAUP*](https://paup.phylosolutions.com/) <br />
[RAxML](https://cme.h-its.org/exelixis/web/software/raxml) <br />

#################################################################################### <br />
**Part 1. Running orthofinder to get a list of single copy orthologues for your species** 

First download complete nucleotide and peptide fasta sets for your species of interest. Gather the peptide fastas in a directory, and then run Orthofinder using the script [orthofinder.sbatch](https://github.com/siribi/MAKING_TREES/blob/main/scripts/orthofinder.sbatch). Remember to change path and the name of the directory (-f flag). If you only have nucleotide sequences, remember to use the flag -d (Input is DNA sequences). 

Orthofinder will give you a list of single copy orthologues in the file "OrthoFinder/Results_XXX00/Orthogroups/Orthogroups_SingleCopyOrthologues.txt", and will even gather the protein sequences for you in the directory "OrthoFinder/Results_XXX00/Single_Copy_Orthologue_Sequences". These sequences need to be aligned using pal2nal. 

Pal2nal must be run with fasta output. Then you can run the script Fasta2Phylip_batch.sh which runs Fasta2Phylip.pl, converting fasta to phylip.

Next we need to make a concatenated phylip file for our downstream RAxML species tree analysis:
NB: Remember that the sequences have to be in the same order in all phylip files!
Here -q stands for quiet (never output header giving file name) and -n stands for lines
```
tail -q -n +2 *pal2nal.phylip >> concat_pal2nal.phylip 
```
Extract field 2 in the header of all phylip files to a new file:
```
head -q -n1 *pal2nal.phylip | awk '{ print $2 }' >> sequence_lengths.txt
```
Sum all values in a file:
```
awk '{ sum += $1 } END { print sum }' sequence_lengths.txt
```
Use nano to open "concat_pal2nal.phylip" and add sequence length. Copy header from other file to get correct spacing.

The next step is to extract the first 9 lines and send it to a new file. Try:
```
head -q -n9 Cardamine_concat.phylip > first_9.phylip
```
Extract the rest of the file into a new fileq
```
tail -q -n +10 Cardamine_concat.phylip > last_lines.phylip
```
Extract column 2:
```
awk '{ print $2 }' last_lines.phylip >> last_lines_oneColumn.phylip
```
Concatenate the two files:
```     
cat first_9.phylip last_lines_oneColumn.phylip > New_Cardamine_concat.phylip
```

NB: THIS FINAL BIT NEEDS TO BE CLARIFIED
How then do I reduce New_Cardamine_concat.phylip??
Here I think I download to my own PC and then open in AliView. From there I can save as a phylip file. 
A bit unsure of what type, but trying to use long names in the first instance...

#################################################################################### <br />
**Part 2. Running MrModeltest to detect most suitable nucleotide substitution model for phylogeny reconstruction** 
Best practice in phylogeny reconstruction usually involves choosing an appropriate nucleotide substitution model. Here I use MrModeltest to choose the best model based on AIC. 

NOTE: This step may not be necessary. A paper by [Abadi et al. 2019](https://www.nature.com/articles/s41467-019-08822-w) in Nature Communications found that skipping model selection and choosing the most parameter-rich model directly (GTR+I +G) may give decent topologies. However, also check this [blogpost](https://www.michaelgerth.net/news--blog/why-we-should-not-abandon-model-selection-in-phylogeny-reconstruction) on why we should not entirely abandon model selection in phylogeny reconstruction. 

First you need to create a nexus file. Previously I have used AliView and then changed the the sets part at the end of the file. See example here. 

Copy the MrModeltest file to the folder along with the nexus file

To run MrModeltest you need PAUP*:
```
     module load paup
```

Enter paup mode (depends on the version you use): 
```
     paup4b10 
```

Run MrModeltest:
```
     execute New_Cardamine_concat_fullnames.nexus
     exclude pos_1;
     exclude pos_2;
     execute MrModelblock
     mv mrmodel.scores mrmodel.scores_pos3
     mv mrmodelfit.log mrmodelfit.log_pos3
```
Note that we change the names mrmodel.scores to mrmodel.scores_pos3 and mrmodelfit.log to mrmodelfit.log_pos3

```
     exclude pos_3;
     include pos_1;
     execute MrModelblock
     mv mrmodel.scores mrmodel.scores_pos2
     mrmodelfit.log mrmodelfit.log_pos2
```

Note that we change the names mrmodel.scores to mrmodel.scores_pos2 and mrmodelfit.log to mrmodelfit.log_pos2

```
     exclude pos_2;
     include pos_3;
     execute MrModelblock
     mv mrmodel.scores mrmodel.scores_pos1
     mv mrmodelfit.log to mrmodelfit.log_pos1
```

Note that we change the names mrmodel.scores to mrmodel.scores_pos1 and mrmodelfit.log to mrmodelfit.log_pos1

Then run Mrmodeltest
```
    mrmodeltest2 < mrmodel.scores_pos1 > out_pos1 
    mrmodeltest2 < mrmodel.scores_pos2 > out_pos2 
    mrmodeltest2 < mrmodel.scores_pos3 > out_pos3 
```

Pick the best model based on the Akaike information criterion (AIC).

#################################################################################### <br />
**Part 3. Running RAxML to make a species tree**
Use the script [run_raxml.sbatch](https://github.com/siribi/MAKING_TREES/blob/main/scripts/run_raxml.sbatch) to run RAxML and by copying and changing the file called [part](https://github.com/siribi/MAKING_TREES/blob/main/examples/part) in the examples directory
