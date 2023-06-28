#!/bin/bash
#Script to prep files for mafft alignments
# Usage: ./run_pal2nal.sh 
# execute in directory with fasta files

FALIST=`ls -1 *.fasta`
i=1
for FAFILE in $FALIST
        do
	#FILEBASE=${FAFILE%.aligned.fasta}
	FILEBASE=$(echo $FAFILE | cut -f1 -d.)
	echo $FILEBASE
 	#sed ':a;N;/^>/M!s/\n//;ta;P;D' $FAFILE > $FILEBASE.unwrap.fasta
	pal2nal $FILEBASE.aligned.fasta nucleotide_files/$FILEBASE.fasta -output paml > $FILEBASE.pal2nal.fasta        
#	echo $FILEBASE	
#	mv $FAFILE $FILEBASE.axt.kaks.$((i++))	
	done
