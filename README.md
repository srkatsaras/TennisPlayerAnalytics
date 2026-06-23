# Tennis Match Analyser
![alt text](https://github.com/srkatsaras/TennisPlayerAnalytics/blob/main/image_readme.jpg)
## Installation
The project can be installed using one of the following ways:
1.  By creating a virtual enviroment and by installing the libraries supplied in the `requirements.txt` file.
__Preferred python version:__ Python 3.10.
```
$ python -m venv ./venv/
$ source venv/bin/activate
(venv)$ pip install -r requirements.txt
```
2.  By utilizing the supplied `Dockerfile` specification. This option is recommended despite not being as lightweight as using a virtual environment.
```
$ docker build --tag project .
$ docker run -d -p 5000:5000 project
```
## Overview
The project 
