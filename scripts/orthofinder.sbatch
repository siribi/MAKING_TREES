#!/bin/bash
# Job name: Orthofinder
#SBATCH --job-name=Orthofinder
#
# Project:
#SBATCH --account=nn8023k
#
# Wall clock limit:
#SBATCH --time=24:00:00
#
# Number of tasks/processes to run:
#SBATCH --ntasks=1
#
# Number of cores:
#SBATCH --cpus-per-task=15
#
# Max memory usage per core (MB):
#SBATCH --mem-per-cpu=8G
#
## Set up job environment:
## Recommended safety settings:
set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
#
#purge and load modules
module purge
module load OrthoFinder/2.5.4-foss-2022a

#Or load Anaconda + a conda environment
#set +eu
#source activate salmon_env
#set -eu

## Now do something useful:
#cd $SCRATCH
cd /cluster/home/siribi/work/EVOTREE/orthofinder/hyphy_May23/
orthofinder -f orthofinder_timetree_RELAX -t 15
