# syntax=docker/dockerfile:1

# base python image for custom image
FROM python:3.10.20-slim

# create working dir and install pip dependencies
WORKDIR /tennis-analyser

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

CMD [ "python3", "main.py" ]
