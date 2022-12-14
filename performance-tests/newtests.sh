#!/bin/bash

cd /home/nicola/PerfTestEC

for NEVENTS in 10 100 200 300 400 500 600 700 800 900 1000
do
    echo Starting test batch with $NEVENTS events
    COUNTER=0
    while [  $COUNTER -lt 100 ]; do
        echo Repetition number:$COUNTER
        
        #parameters: nEvents, type, outputFilePath
        java -jar gendataset.jar $NEVENTS 2 data2.csv
        java -jar gendataset.jar $NEVENTS 4 data4.csv
        java -jar gendataset.jar $NEVENTS 6 data6.csv
        java -jar gendataset.jar $NEVENTS 8 data8.csv
        
        #parameters: inputDatasetPath, engineChoice, resultFilePath
        java -jar runtest.jar data2.csv 3 res2.csv
        java -jar runtest.jar data4.csv 3 res4.csv
        java -jar runtest.jar data6.csv 3 res6.csv
        java -jar runtest.jar data8.csv 3 res8.csv

        java -jar runtest.jar data2.csv 6 res2.csv
        java -jar runtest.jar data4.csv 6 res4.csv
        java -jar runtest.jar data6.csv 6 res6.csv
        java -jar runtest.jar data8.csv 6 res8.csv 
        
        let COUNTER=COUNTER+1 
    done
done
