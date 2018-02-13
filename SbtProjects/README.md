# DataScienceWork

Repository for project code

## Prerequisites

* SBT installed
* Connection to the internet

## Instructions for Running SBT on hadoop

1. Change/create directory for project
```
cd SmartCollectDataLoad
```
2. Clone repository from bitbucket
```
git clone https://github.com/DanielaCasilli/DataScienceWork.git
```
3. Open in IntelliJ/text editor for editing, if necessary. Ensure "save" file directory is correct.
4. ssh into hadoop
```
ssh username@22.hadoop
```
5. Start spark shell and run commands
6. Quit spark shell and Transfer file to Shiny Server
```
// quit spark shell
:q

//list files in hadoop
hdfs dfs -ls

// transfer first from hdfs to remote machine
hdfs dfs -copyToLocal /user/daniela/data/ ./

// copy from local to local Shiny server
scp /user/daniela/data/textfile.csv usernmae@22.hadoop:/srv/project/
exit
```

## Authors

* **Daniela Casilli** - *Initial Work*


## Acknowledgments
* Hat tip to anyone who's code was used
