import tools
import config
import pandas as pd
import numpy as np
import urllib

def fetchID(name):
    try:
        genus, species = name.split(" ")
        req = "{genus}%20{species}?marine_only=true".format(genus = genus, species=species)
    except:
        req = "{name}?marine_only=true".format(name = name)
    try:
        ID = int(urllib.request.urlopen("http://www.marinespecies.org/rest/AphiaIDByName/{req}".format(req = req).read().decode('utf8').replace("'", '"'))
    except Exception as e:
        print(e)
        print("Couldn't fetch Taxonomy, abort...")
 return ID 

def fetchTaxonomy(ID):
    url = "http://www.marinespecies.org/rest/AphiaClassificationByAphiaID/{ID}?marine_only=true".format(ID = ID)
    try:
        answer = urllib.request.urlopen(url).read().decode('utf8').replace("'", '"')
    except Exception as e:
        print(e)
        print("Couldn't fetch Taxonomy, abort...")
    data = json.loads(answer)
    taxo = {}
    x = data
    while x['child'] is not None: 
        x = x['child']
        taxo[x['rank'].lower()] = x['scientificname']
    return taxo

def addTaxonomy(df_target, df_source):
    '''
    Be sure to have a species column in both arrays before continuing
    Be sure to put the taxonomy values in df_source
    '''
    df1 = df_target
    df2 = df_source
    ranks = ['worms_id', 'kingdom', 'phylum', 'class', 'order', 'family', 'genus', 'species']
    for rank in ranks:
        df1[rank] = None
    try:
        df1_sp = set(df1.species):
        df2_sp = set(df2.species):
    except Exception as e:
        print(e)
        print("Sanitize df1 and df2 first")
    
    for sp in df1_sp:
        if sp in df2_sp: #if target species among source species, add taxonomy
            for rank in ranks:
                rank_set = set(df2[df2.species == sp][rank])
                if len(rank_set) == 1:
                    df1.at[df1.species == sp, rank] = rank_set.pop()
                else:
                    print("Please sanitize data first")
                    pass
                    #resolv conflict... Most common ? Or use internet ?
        else:
            taxonomy = fetchTaxonomy(fetchID(sp))
            for rank in ranks:
                df1.at[df1.species == sp, rank] = taxonomy[rank]
    return df1
    
            
 
 

 
 
