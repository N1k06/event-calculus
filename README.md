# Cached & Indexed EC for Diabetes Monitoring

The Event Calculus (EC) is a First Order Logic formalism to represent properties of the world and how they evolve with time. Given its expressiveness and reasoning capabilities, it is a particularly useful tool to build intelligent agents.

Applying logic reasoning to monitoring scenarios is indeed a challenging task, given the high amount of data and rules that have to be checked. Even though the Cached EC improves standard EC by moving computation from query time to update time and by proposing a caching technique for fluents, this is sometimes not enough. Indexing strategies can provide a further optimization by handling ordered data more efficiently.
This repository contains material to run different Cached and Indexed EC-based agent minds on text logs extracted from Continuous Glucose Monitoring (CGM) dataset and realistic synthetic datasets.

Physiological records in the datasets (Blood Glucose and Blood Pressure) are treated as events within the EC formalism; such records have to be fed to the agent minds, and can trigger the monitoring rules included in them.

## Prerequisites

Java Runtime Environment 8 or newer.


## Monitoring Rules

The agent minds have been bundled with two monitoring rules that check Blood Pressure and Blood Glucose measurements with the goal of detecting pre-hypertension and brittle diabetes conditions.
Such monitoring rules have been implemented by following Complex and Sequential Rule Patterns.
Please refer to this [paper](https://todo) for a detailed description.

## Synthetic Datasets
  
Synthetic Datasets allow to stress the agent minds on specific rules and conditions. 
A Synthetic dataset can be created by running:
```
java -jar gendataset.jar <NEVENTS> <SCENARIO> <OUTFILE>
```
Parameters description:
* ```<EVENTS>```: Number of physiological records in the generated dataset.
* ```<SCENARIO>```: Integer going from 1 to 8 (see below).
* ```<OUTFILE>```: Path to the file on which the dataset will be saved.


Table describing the meaning of ```<SCENARIO>``` codes:

| Event Condition\Rule Pattern  | Sequential | Complex |
|-------------------------------|:----------:|:-------:|
| **Dense**                     | 2          | 6       |
| **Sparse**                    | 4          | 8       |

The Event Condition affects the inter-arrival time between different physiological measurements.
This parameter directly affects reasoning performance, as a high event time granularity traduces to a more stressful rule checking. 
For a more detailed description, please refer to this [paper](https://todo).


## CGM Dataset

Parts of [this](https://t1dexchange.org/pages/resources/our-data/studies-with-data/) dataset have been included this repository.
They have been put inside the  ```CGMDataset``` directory, in the form of .csv files that be can easily fed in the EC agent minds.  

## Running the tests

The agent minds can be tested by running the following command:
```
java -jar runtests.jar <INFILE> <ENGINE> <OUTFILE>
```

Parameters description:
* ```<INFILE>```: Path to the .csv file containing the physiological records (events) that have to be fed into the agent mind.
* ```<ENGINE>```: Integer going from 1 to 8 (see below).
* ```<OUTFILE>```: Path to a .csv file in which the reasoning results (computation time, number of alerts generated and number of events) will be saved.

Description of the ```ENGINE``` parameter. Each number corresponds to a different reasoning engine (todo):
*1 TEC-KDT ...
*2 TEC-IT ...
*3 JREC ...
*4 JREC-RBT ...
*5 NO-EC ...

For a more detailed description, please refer to this [paper](https://todo).
