# Pharmap

# Installation

```shell
pipenv install
pipenv shell
python3 src/index.py
```
# Usage 
## AI
### Launch training and evaluation

To see the help and all options :

```shell
python3 src/ai/index.py -h
```

Run one training  with the network config in conf.py with all classes have more 50 samples on 100 epochs:

```shell
python3 src/ai/index.py  --file_input 'data/out/coraux_geov2.csv' -epochs 100  --do_standardization --filter_taxon_rank 'species' --min_sample_size 50
```

Run the search of the optimal parameters (train multiple networks and compare the performances)

```shell
python3 src/ai/index.py  --file_input 'data/out/coraux_geov2.csv' --do_standardization --filter_taxon_rank 'species' --run_multiple_config
```


### Results

| nb_epochs | nb_class (>min_sample_size) | date_run      | top1   | top2  | top3  | top4  | top5        |
| --------- | --------------------------- | ------------- | ------ | ----- | ----- | ----- | ----------- |
| 100       | 574 classes (>10 samples)   | 191118-180901 | 0.5751 | 0.737 | 0.811 | 0.841 | **0.875**   |
| 100       | 383 classes (>20 samples)   | 191118-133229 | 0.58   | 0.760 | 0.826 | 0.864 | **0.889**   |
| 100       | 218 classes (>50 samples)       | 191118-183441 | 0.608  | 0.783 | 0.851 | 0.891 | **0.914**   |
| 100       | 149 classes (>100 samples)  | 191118-115200 | 0.625  | 0.803 | 0.870 | 0.908 | **0.931**   |
| 100       | 53 classes (>500 samples)   | 191118-165139 | 0.693  | 0.874 | 0.935 | 0.962 | ***0.977*** |
