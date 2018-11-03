import tools
import config
import pandas as pd
from ete3 import Tree, TreeStyle, NCBITaxa, NodeStyle, faces, AttrFace, TreeFace
import itertools

class PhyloTree(Tree):
    '''
    TODO :
           Put the distribution and environmental pandaDataframe without useless columns (taxonomy) thus making the whole data lighter
           PICKLE the tree for persistence
    '''
    def __init__(self, **kwargs):
        Tree.__init__(self)
        self.mytest = kwargs.get("mytest", None)
        self.df= kwargs.get("dataframe", None)
        self.ranks = ["phylum","class", "order", "family", "genus", "species"]
        self.leaf_attributes = kwargs.get('leaf_attributes', ['latitude', 'longitude', 'depth'])

        '''
        TODO : Find a way to add them without getting lost in recursion
        self.add_child(name="Animalia").add_features(rank="kingdom")
        self.add_child(name="Plantae").add_features(rank="kingdom")
        self.add_child(name="Fungi").add_features(rank="kingdom")
        self.add_child(name="Protista").add_features(rank="kingdom")
        '''

    def build_tree(self, **kwargs):

        v = kwargs.get("verbose", False)
        assign_data = kwargs.get("assign_data", False)

        if self.df.empty:
            raise Exception('Need dataframe for build')
        self.add_child(name="Animalia").add_features(rank="kingdom")

        last = "kingdom"
        for rank in self.ranks:
            for sci_name in set(self.df[rank]):
                if sci_name and sci_name != "nan" and isinstance(sci_name, str):
                    parents = set(self.df.loc[self.df[rank]==sci_name][last]).pop()
                    if parents and parents != "nan" and isinstance(parents, str):
                        parent_nodes = self.search_nodes(name=parents)
                        print("Adding ",sci_name," descendant of ", parent_nodes) if v else None
                        try:
                            parent_node = [x for x in parent_nodes if x.name != "nan"][0]
                            parent_node.add_child(name=sci_name).add_features(rank=rank)
                        except Exception as e:
                            print(e)
            last = rank

        self.assign_data_tree(**kwargs) if assign_data else None

    def build_from_csv(self, **kwargs):
        '''
        builds a phylo tree from a csv table. Please be sure there are no missing rank in the classification.
        '''
        v = kwargs.get("verbose", False)
        csv = kwargs.get("file", None)
        if csv:
            try:
                self.df = pd.read_csv(csv)
            except Exception as e:
                print("Couldn't open file : ", e)
                return e
        self.build_tree(**kwargs)


    def assign_data_tree(self, **kwargs):
        '''
        Assign given attributes to each node in pandas DataFrame form.
        '''
        v = kwargs.get("verbose", False)

        for leaf in self.get_leaves():
            print(leaf.name) if v else none
            leaf.add_features(data=self.df.loc[self.df[leaf.rank]==leaf.name][self.leaf_attributes])

    def get_dataframe(self):
        '''
        return dataframe of data attributes of node leaves
        '''
        newdf = pd.DataFrame()
        for leaf in self.get_leaves():
            newdf = newdf.append(leaf.data)
        return newdf

    def count(self, **kwargs):
        '''
        Return the number of occurence as a series, return number of row by default
        '''
        size = len(self.df.index)
        rank = kwargs.get("rank", False)
        name = kwargs.get("name", False)
        if rank:
            if name:
                return len(self.df.loc[df[rank]==name])
            return self.df.groupby(rank).size()
        else:
            return pd.Series(data=size)
