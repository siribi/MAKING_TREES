#!/bin/bash
# Job name:
#SBATCH --job-name=mrmodel
#
# Project:
#SBATCH --account=nn9370k
#
# Wall clock limit:
#SBATCH --time=48:00:00
#
# Max memory usage per core (MB):
#SBATCH --mem-per-cpu=32G
#
# Number of cores:
#SBATCH --cpus-per-task=1
#
## Set up job environment:
source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors

module load raxml

## Define some stuff
ALIGNMENT=
OUTFILE=
RAND=
MODEL=

## Now do something useful:
cd ~/

## Run RAxML
raxmlHPC -s $ALIGNMENT -n $OUTFILE -p $RAND -m $MODEL



