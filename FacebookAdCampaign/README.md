# DataScienceWork

Repository for project code

## Shiny App Information

To access the app
```
http://publicIP:3838/sample-apps/hello/
```
To access RStudio via instance
```
Publci DNS (IPv4) in browser
```

### Helpful tips
To change write access of a folder
```
sudo chown user:user /srv/shiny-server/facebookAd/
```
To find user name
```
echo $USER
```



## Setting up Shiny Server on AWS Instance

Set up instacne on AWS from http://www.exegetic.biz/blog/2015/05/hosting-shiny-on-amazon-ec2/

### ssh into instance
Make sure key not publically avaialble
```
chmod 400 file.pem
```
Ssh with key file into instance
```
ssh -l ubuntu -i AWS-key.pem ubuntu@ecIP.us-west-2.compute.amazonaws.com
```


### Install R
```
sudo apt-get update  
sudo apt-get install r-base  
sudo apt-get install r-base-dev
```


### Install Shiny
```
sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""
```

### Install Shiny Server
```
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.4.807-amd64.deb
sudo dpkg -i shiny-server-1.4.4.807-amd64.deb
```

### Running Application
Move app under location:
```
/srv/shiny-server/
```
Acces app 
```
http://ecIP.us-west-2.compute.amazonaws.com:3838/appName
```



### NB Install R packages
```
sudo su - -c "R -e \"install.packages('dplyr', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('ggplot2', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('tidyr', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('scales', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('xml2', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('rvest', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shinyLP', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shinyBS', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shinythemes', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shinydashboard', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shinycssloaders', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('readr', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('openssl', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('plotly', repos='http://cran.us.r-project.org')\""
```

### NB install other package dependencies
```
sudoapt-get install libssl-dev
sudo apt-get install libxml2-dev
```


## Authors

* **Daniela Casilli** - *Initial Work*


## Acknowledgments
* Hat tip to anyone who's code was used
