import tools
import config
import pandas as pd
from ete3 import Tree, TreeStyle, NCBITaxa, NodeStyle, faces, AttrFace, TreeFace
import itertools

class PhyloTree():
    '''
    TODO : Make it inherit from ete3 Tree class thus changing the ugly self.t to self
           Put the distribution and environmental pandaDataframe without useless columns (taxonomy) thus making the whole data lighter
           PICKLE the tree for persistence
    '''
    
    def __init__(self, **kwargs):
        self.t = Tree()
        self.t.add_child(name="Animalia").add_features(rank="kingdom")
        self.t.add_child(name="Plantae").add_features(rank="kingdom")
        self.t.add_child(name="Fungi").add_features(rank="kingdom")
        self.t.add_child(name="Protista").add_features(rank="kingdom")
        self.df = kwargs.get("dataframe", None)

    
    def build_from_csv(self, csv, **kwargs):
        '''
        builds a phylo tree from a csv table. Please be sure there are no missing rank in the classification.
        '''
        v = kwargs.get("verbose", False)
        
        try:
            self.df = pd.read_csv("/home/jack/Documents/HACKATON/OceanData/coral/datadrive/porifera_obis_light.csv")
        except Exception as e:
            print("Couldn't open file : ", e)
            return e
        
        ranks = ["phylum","class", "order", "family", "genus", "species"]
        
        last = "kingdom"
        for rank in ranks:
            for sci_name in set(self.df[rank]):
                if sci_name and sci_name != "nan" and isinstance(sci_name, str):
                    parents = set(self.df.loc[self.df[rank]==sci_name][last]).pop()
                    if parents and parents != "nan" and isinstance(parents, str):
                        parent_nodes = self.t.search_nodes(name=parents)
                        print("Adding ",sci_name," descendant of ", parent_nodes) if v else None
                        try:
                            parent_node = [x for x in parent_nodes if x.name != "nan"][0]
                            parent_node.add_child(name=sci_name).add_features(rank=rank)
                        except Exception as e:
                            print(e)
            last = rank
    
    def give_attributes():
        pass
    
    
    def show(self, **kwargs):
        self.t.show(**kwargs)
