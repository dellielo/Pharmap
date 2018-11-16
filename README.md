# Pharmap

# Installation

```shell
pipenv install
pipenv shell
python3 src/index.py
```
# Usage 
## AI
To see the help :

```shell
python3 src/ai/index.py -h
```

Run one training  with the network config in conf.py

```shell
python3 src/ai/index.py  --file_input 'data/out/coraux_geov2.csv' -e 100  -s --filter_taxon_rank 'species'
```

Run the search of the optimal parameters (train multiple networks and compare the performances)

```shell
python3 src/ai/index.py  --file_input 'data/out/coraux_geov2.csv' -s --filter_taxon_rank 'species' --run_multiple_config
```