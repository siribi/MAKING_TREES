#!/bin/bash
# Job name:
#SBATCH --job-name=raxml
#
# Project:
#SBATCH --account=nn9370k
#
# Wall clock limit:
#SBATCH --time=100:00:00
#
# Max memory usage per core (MB):
#SBATCH --mem-per-cpu=15G
#
# Number of cores:
#SBATCH --cpus-per-task=4
#
## Set up job environment:
source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors

module load raxml

## Define some stuff
ALIGNMENT=New_Draba_concat_fromAliView3.phy
OUTFILE=Draba_run2
RAND=98274
MODEL=GTRGAMMAI
PARTS=part

##copy files to scratch
cp $SUBMITDIR/$PARTS $SCRATCH
cp $SUBMITDIR/$ALIGNMENT $SCRATCH

##checkful
#chkfile RAxML_*
#chkfile Draba_run2*
cleanup "cp -rf $SCRATCH $SUBMITDIR" 

## Now do something useful:
cd $SCRATCH

## Run RAxML
raxmlHPC -s $ALIGNMENT -n $OUTFILE -p $RAND -q $PARTS -m $MODEL -T 4
