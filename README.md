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
> Show you all available option to train our neural network

# Data structuration
This is how we regroup data and link them together
```
python3 src/data_structuration/index.py
```

> This command process all data and save the result file on data/out

### Config

A lot of parameter can be edited in `src/data_structuration/config.py`.

There are 3 method available
 - offset (mean all data find near the point)
 - nearest (find the closest data of the point)
 - meanNearest (weighted average of data near the point)

The fast one is by offset
The accurate one is by meanNearest

# Crawler
explication of the crawler
