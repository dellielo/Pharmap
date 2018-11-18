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
# Ai
```
python3 src/ai/index.py --help
```
> Show you all of the available options to train our neural network

# Data structuration
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

# Crawler
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

# Web app

The web app is actually in building state

##  Server

We use flask for our server and a sql database

Command to start the server:
```
	cd website/server
	python3 -m flask run
```
### list species
Route `/getSpecies`
Methode: `get`
Body:
```js
{
	max: 300 // the max number of species returned (default return all)
	offset: 100 // the offset in list (default 0)
}
```
Retour:
```js
{
	//incoming
}
```
### Get predictions

Route `/{speciesId}/prediction`
Methode: `get`
Body:
```js
{
	latitude: [60, 70] // [start, end]
	longitude: [100, 120] // [start, end]
}
```
Retour:
```js
{
	[
		lattitue: 63,2
		longitude: 112
		prediction: 0.8 // probability that the species can be find at this localisation
	],
	...
}
```
## client
We use ReactJS

It is located in `website/client`

installation `npm install`

Start client: `npm start`