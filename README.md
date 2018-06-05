# Cached and Indexed Event Calculus for Diabetes Monitoring

The Event Calculus (EC) is a First Order Logic formalism to represent properties of the world and how they evolve with time. Given its expressiveness and reasoning capabilities, it is a particularly useful tool to build intelligent agents. 
Applying logic reasoning to monitoring scenarios is indeed a challenging task, given the high amount of data and rules that have to be checked. Even though the Cached EC improves standard EC by moving computation from query time to update time and by proposing a caching technique for fluents, this is sometimes not enough. Indexing strategies can provide a further optimization by handling ordered data more efficiently.
This repository contains material to run different Cached and Indexed EC-based agent minds on text logs extracted from Continuous Glucose Monitoring (CGM) dataset and realistic synthetic datasets.
Physiological records in the datasets (Blood Glucose and Blood Pressure) are treated as events within the EC formalism; such records have to be fed to the agent minds, and can trigger the monitoring rules included in them.

## Prerequisites

Java Runtime Environment 8 or newer.

## Synthetic Datasets
  
Synthetic Datasets allow to stress the agent minds on specific rules and conditions. 
A Synthetic dataset can be created by running:
```
java -jar gendataset.jar <NEVENTS> <SCENARIO> <OUTFILE>
```
Parameters description:
* ```<EVENTS>```: Number of physiological records in the generated dataset.
* ```<SCENARIO>```: Integer going from 1 to 8.
* ```<OUTFILE>```: Path to the file on which the dataset will be saved.


Table describing the meaning of ```<SCENARIO>``` codes:
| Event Condition\Rule Type | Sequential | Complex |
|----------------------------|------------|---------|
| **Dense**                      | 2          | 6       |
| **Sparse**                     | 4          | 8       |

The Event Condition affects the inter-arrival time between different physiological measurements. Instead, for a more detailed description of Rule Types, please refer to this [paper](https://www.researchgate.net/profile/Davide_Calvaresi/publication/321282796_Event_Calculus_Agent_Minds_Applied_to_Diabetes_Monitoring/links/5a1bc3144585155c26ae034f/Event-Calculus-Agent-Minds-Applied-to-Diabetes-Monitoring.pdf).


## CGM Dataset

Parts of [this](https://t1dexchange.org/pages/resources/our-data/studies-with-data/) dataset have been included this repository.
They have been put inside the  ```CGMDataset``` directory, in the form of .csv files that be can easily fed in the EC agent minds.  

## Running the tests

TODO

```
TODO
```
