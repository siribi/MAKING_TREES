#!/bin/bash
# Job name: Run python prep script
#SBATCH --job-name=pal2nal
#
# Project:
#SBATCH --account=nn9370k
#
# Wall clock limit:
#SBATCH --time=3:00:00
#
# Max memory usage per core (MB):
#SBATCH --mem-per-cpu=5G
#
# Number of cores:
#SBATCH --cpus-per-task=1
#
## Set up job environment:
source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors
unset LC_CTYPE

#load modules
#module load mafft

## Now do something useful:
cd /usit/abel/u1/siribi/nobackup/COLD/pal2nal/Grand_conv/CbA/

## Run the pal2nal script
./run_pal2nal.sh
