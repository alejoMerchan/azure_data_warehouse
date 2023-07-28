Building an Azure Data Warehouse for Bike Share Data Analytics
==============================================================

# Context

This is the solution of the assignment "Building an Azure Data Warehouse for Bike Share Data Analytics" from
UDACITY course "Data Engineering with Microsoft Azure".

# Problem

## Project Overview

Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or
use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount
of time.
The bikes can be returned to the same station or to another station.
The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can
analyze the data.

Since the data from Divvy are anonymous, we have created fake rider and account profiles along with fake payment
data to go along with the data from Divvy. The dataset looks like this:


![initial model](/model.png)

The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. You will:

Design a star schema based on the business outcomes listed below;
Import the data into Synapse;
Transform the data into the star schema;
and finally, view the reports from Analytics.

# Solution

## Star Schema

![star schema](/star_schema.png)

## Load

Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. From here, you can use the
script-generating function to load the data from blob storage into external staging tables in the data warehouse you 
created using the serverless SQL Pool.

### Solution

Queries with the problem solution are in the folder /load

## Data Warehouse

Implementation of the star schema using CETAS(Create External Tables as Select)

### Solution

Queries with the problem solution are in the folder /datawarehouse






