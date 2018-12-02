# Pharmap
Project link: [here](https://projets.aiforabetterworld.bemyapp.com/#/projects/5bba650454a8770004b25ccc)

# Installation

Requirment: python3.6

install pipenv if not installed
```
python3 -m pip install pipenv --user
```
Create virtual environment
```
pipenv install
pipenv shell
```

# Usage 
## AI
### Launch training and evaluation


```shell
python3 src/ai/index.py --help
```
> Show you all of the available options to train our neural network:



```shell
python3 src/ai/index.py  --file_input 'data/out/coraux_geov2.csv' -epochs 100  --do_standardization --filter_taxon_rank 'species' --min_sample_size 50
```
> Run one training  with the network config in conf.py with all classes have more 50 samples on 100 epochs


```shell
python3 src/ai/index.py  --file_input 'data/out/coraux_geov2.csv' --do_standardization --filter_taxon_rank 'species' --run_multiple_config
```
> Run the search of the optimal parameters (train multiple networks and compare the performances)


### Results on species

| nb_epochs | nb_class (>min_sample_size) | date_run      | top1   | top2  | top3  | top4  | top5        |
| --------- | --------------------------- | ------------- | ------ | ----- | ----- | ----- | ----------- |
| 100       | 574 classes (>10 samples)   | 2018-11-19_180901 | 0.5751 | 0.737 | 0.811 | 0.841 | **0.875**   |
| 100       | 383 classes (>20 samples)   | 2018-11-19_133229 | 0.58   | 0.760 | 0.826 | 0.864 | **0.889**   |
| 100       | 218 classes (>50 samples)       | 2018-11-19_183441 | 0.608  | 0.783 | 0.851 | 0.891 | **0.914**   |
| 100       | 149 classes (>100 samples)  | 2018-11-16_150836 (*) | 0.625  | 0.803 | 0.870 | 0.908 | **0.931**   |
| 100       | 53 classes (>500 samples)   | 2018-11-16_155759 (**) | 0.693  | 0.874 | 0.935 | 0.962 | ***0.977*** |
> Find details in /data/bestModel/reports with date_run

> (*) save in data/bestModel/model1 

> (**) save in data/bestModel/model2 

## Data structuration
This is how we regrouped the data and linked them together. It use panda and numpy to perform fast operation
```
python3 src/data_structuration/index.py
```

> This command processes all data and saves the results file on data/out

### Config

A lot of parameter can be edited in `src/data_structuration/config.py`.

There are 3 methods available
 - offset (mean all data found near the point)
 - nearest (find the closest data to the point)
 - meanNearest (weighted average of data near the point)

The fast one is by offset
The accurate one is by meanNearest

## Crawler
Only the most desperate beings venture in the crawler.

You can use the crawl function to explore the "mdpi" website and return a dict of species, molecules, articles.
It automatically adds molecules linked to species in the neo4j database.
The function saves  the dict, explored links and to be explored links as pickle files.
You can (and should) write your own script to launch the function at given intervals.
You are also encouraged to tweak it to explore older issues and difficult article to parse.

```
driver = dbDriver(uri, user, login)
crawl(domain=urldomain, start=startingpoint, runlength=N)
```

> Will run it at first time. Domain is the website url; start is the href you want to use, it has a default.
Run lenght is the number of links that will be explored from the starting.

```
visited = pickle.load(open("saved_visited.p", "rb"))
links = pickle.load(open("saved_links.p","rb"))
rdict = pickle.load(open("saved_dict.p","rb"))
mydict.update(crawl(domain=urldomain, start=startingpoint, runlength=N, links=links, visited=visited, rdict=rdict))
```

> Will resume the crawler

## Web app

### Server

We use ExpressJS
It's just a dump server that execute query on neo4j db

Command to install and start the server:

```
cd website/server
npm install
npm start
```

Route `/query`
Methode: `post`
body:
```js
{
	query: "MATCH (m:molecule) RETURN collect(m.name)"
    endpoint: "bolt://35.189.195.75"
    username: "neo4j"
    password: "neo4j"
}
```
It return the result of your query

### client

We use ReactJS

Command to install and start the client:
```
cd website/client
npm install
npm start
```

**Molecule Tab**
On this tab you can get access of all molecules that we handle. By clicking on one of them you access to the details of this molecule and  a map that display the localisation of corals which contain this molecule

**Configure Tab**
This is where you enter your credentials for the neo4j database
