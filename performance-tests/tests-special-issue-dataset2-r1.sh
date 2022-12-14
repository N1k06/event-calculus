#!/bin/bash

cd /home/nicola/PerfTestEC

for NEVENTS in 100 500 1000 1500 2000 2500 3000
do
    echo Starting test batch with $NEVENTS events
    COUNTER=0
    while [  $COUNTER -lt 10 ]; do
        echo Repetition number:$COUNTER

        #parameters: nEvents, type, outputFilePath
        java -jar gendataset.jar $NEVENTS 2 data2.csv
        java -jar gendataset.jar $NEVENTS 4 data4.csv
        java -jar gendataset.jar $NEVENTS 6 data6.csv
        java -jar gendataset.jar $NEVENTS 8 data8.csv

        #parameters: inputDatasetPath, engineChoice, resultFilePath
        #kdtree
        #java -jar runtest.jar data2.csv 1 res2.csv

        #inttree
        #java -jar runtest.jar data2.csv 2 res2.csv

        #jrec-rbt
        #java -jar runtest.jar data2.csv 6 res2.csv

        #no-ec
        java -jar runtest.jar data2.csv 7 res-no-ec2.csv
        java -jar runtest.jar data4.csv 7 res-no-ec4.csv
        java -jar runtest.jar data6.csv 7 res-no-ec6.csv
        java -jar runtest.jar data8.csv 7 res-no-ec8.csv

        let COUNTER=COUNTER+1
    done
done
