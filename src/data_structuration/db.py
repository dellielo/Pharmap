from neo4j import GraphDatabase


class dbDriver(object):

    def __init__(self, uri, user, password):
        self._driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self._driver.close()

    def add_node(self, message):
        with self._driver.session() as session:
            greeting = session.write_transaction(self._create_node, message)
            print(greeting)

    def add_prop_to_mol(molecule, effect):
        txt = '\
        MATCH (m:molecule) WHERE m.name="'+molecule+'"\
        MERGE (e:effect {name:"'+effect+'"})\
        MERGE (m)-[:haseffect]->(e)'
        self.add_node(txt)
        
    def add_mol_to_sp(molecule, sp, L):    
        print(molecule, sp, L)
        txt = '\
        MATCH (sp) WHERE sp.name="'+sp+'"\
        MERGE (m:molecule {name:"'+molecule+'"})\
        MERGE (sp)-[:has {L:'+str(L)+'}]->(m)'
        self.add_node(txt)

    def db_addchild(self, parent_name, child_rank, child_name):
        txt = ('MATCH (p) WHERE p.name="'+parent_name+'"'\
              'CREATE (c:'+child_rank+'{name:"'+child_name+'"})-[:parent]->(p)')
        self.add_node(txt)

    @staticmethod
    def _create_node(tx, message):
        result = tx.run(message)
