# MAKING_TREES
# WORKFLOW FOR MAKING GENE AND SPECIES TREES FOR COMPARATIVE PHYLOGENETIC ANALYSIS
This repository contains scripts for generating gene a species tree and gene trees for phylogenetic analyses 

The scripts are written in bash and R for a slurm based computing cluster like this one: https://documentation.sigma2.no/jobs/job_scripts/saga_job_scripts.html

# PART 1. MAKING ALIGNMENTS FROM ORTHOGROUPS
#################################################################################### <br />

I use the following programs for making trees: <br />
[ORTHOFINDER](https://github.com/davidemms/OrthoFinder) <br />
[RAxML](https://cme.h-its.org/exelixis/web/software/raxml) <br />
[MrModeltest](https://github.com/nylander/MrModeltest2) <br />

#################################################################################### <br />
**Part 1. Running orthofinder to get a list of single copy orthologues for your species** 


#################################################################################### <br />
**Part 2. Running RAxML to make a species tree**
