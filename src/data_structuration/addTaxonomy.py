import tools
import config
import pandas as pd
import numpy as np
import urllib
import json

def fetchID(name):
    ID = None
    try:
        genus, species = name.split(" ")
        req = "{genus}%20{species}?marine_only=true".format(genus = genus, species=species)
    except:
        req = "{name}?marine_only=true".format(name = name)
    try:
        ID = int(urllib.request.urlopen("http://www.marinespecies.org/rest/AphiaIDByName/{req}".format(req = req)).read().decode('utf8').replace("'", '"'))
    except Exception as e:
        print("Couldn't fetch Taxonomy, abort...")
        raise(e)
    return ID

def fetchTaxonomy(ID):
    url = "http://www.marinespecies.org/rest/AphiaClassificationByAphiaID/{ID}?marine_only=true".format(ID = ID)
    try:
        answer = urllib.request.urlopen(url).read().decode('utf8').replace("'", '"')
    except Exception as e:
        print("Couldn't fetch Taxonomy, abort...")
        raise(e)
    data = json.loads(answer)
    taxo = {}
    x = data
    while x['child'] is not None:
        x = x['child']
        taxo[x['rank'].lower()] = {"name":x['scientificname'], "id":x["AphiaID"]}
    return taxo


def addTaxonomy(df_target, df_source, log=True, **kwargs):
    '''
    Be sure to have a species column in both arrays before continuing
    Be sure to put the taxonomy values in df_source
    '''
    df1 = df_target
    df2 = df_source
    noRankId = ['kingdom']
    ranks = ['kingdom', 'phylum', 'class', 'order', 'family', 'genus', 'species']
    columns = ranks + [ rank + "_id" for rank in ranks if rank not in noRankId]

    df1_sp = None
    df2_sp = None
    for c in columns:
        if c not in df1.columns: #prevent overriding species
            df1[c] = None
    try:
        df1_sp = set(df1.species)
        df2_sp = set(df2.species)
    except Exception as e:
        print("Sanitize df1 and df2 first")
        raise(e)

    for sp in df1_sp:
        if sp in df2_sp: #if target species among source species, add taxonomy
            for c in columns:
                c_set = set(df2[df2.species == sp][c])
                if len(c_set) == 1:
                    df1.at[df1.species == sp, c] = c_set.pop()
                else:
                    print("Please sanitize data first")
                    continue
                    #resolv conflict... Most common ? Or use internet ?
        else:
            taxonomy = None
            try:
                taxonomy = fetchTaxonomy(fetchID(sp))
            except Exception as e:
                continue
            for rank in ranks:
                if not rank in taxonomy:
                    print('missing {rank} in taxonomy'.format(rank=rank))
                    continue
                df1.at[df1.species == sp, rank] = taxonomy[rank]["name"]
                if (rank not in noRankId):
                    df1.at[df1.species == sp, rank+"_id"] = taxonomy[rank]["id"]
    return df1