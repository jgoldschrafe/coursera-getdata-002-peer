Getting and Cleaning Data Peer Assignment
=========================================

Introduction
------------
The function of this script is to average a number of data points collected from
UCI's Human Activity Recognition Using Smartphones dataset, located
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
When run, the script will produce a data set containing the averages of the mean
and standard deviation measurements for both the test and training data set,
broken down by the ID of the participant and the activity they were performing
at the time of the measurement (e.g. standing, laying down).

Requirements
------------
This script does not require any additional packages. It has been tested with R
3.0.0 for x86_64 on Windows 7 and Mac OS X.

Running the script
------------------
To run the script:

- Download the `run_analysis.R` script from this repository.
- Download the UCI HCI dataset from 
  [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
  and extract it into a folder called `dataset` alongside the `run_analysis.R`
  script.
- Ensure that your current working directory is set to the directory that
  contains the `run_analysis.R` script, then execute `run_analysis.R`.
  
Output data
-----------
The script will produce a file called `result.txt` in the project directory. The
file is a space-separated data file with column headings suitable for reading into R with:

    read.table('result.txt', header = TRUE)
    
For descriptions of the fields in the output data, please review the `CodeBook.md` file
in the repository.