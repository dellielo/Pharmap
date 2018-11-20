aiDataDir = 'data/aiData/'

#order is important
inputFields = ['temperature.csv', 'DepthInMeters', 'phosphate.csv', 'oxygen.csv', 'salinity.csv', 'nitrate.csv']

outputField = "output"

possibleSelectField = ['family_id', 'genus_id', 'class_id', 'phylum_id', 'species_id', 'kingdom']
selectedField = 'species' #species' #species' #genus' #family_id'

network =  {'epochs': 100, 
            'optimizer': 'adam', 
            'activation': 'tanh', 
            'batch_size': 100, 
            'act_final': 'softmax', 
            'init_mode': 'glorot_normal'} 

