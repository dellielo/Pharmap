from neo4j import GraphDatabase
from molregex import DRUGCLASS

class dbDriver(object):

    def __init__(self, uri, user, password):
        self._driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self._driver.close()

    def push_transaction(self, message):
        with self._driver.session() as session:
            result = session.write_transaction(self._run, message)
            return result
    
    def time_transaction(self, message):
        result = self.push_transaction(message)
        avail = result.summary().result_available_after
        cons = result.summary().result_consumed_after
        total_time = avail + cons
        return result, total_time
    
    def v_push_transaction(self, message):
        print("Sending transaction :")
        print(message)
        result = push_transaction(message)
        print("Received result :")
        print(result)
        return result
    
    @staticmethod
    def _run(tx, message):        
        result = tx.run(message)
        return result
    
    """
    Below are requests
    """
    
    
    def add_prop_to_mol(self, molecule, effect):
        txt = '\
        MATCH (m:molecule) WHERE m.name="'+molecule+'"\
        MERGE (e:effect {name:"'+effect+'"})\
        MERGE (m)-[:haseffect]->(e)'
        self.push_transaction(txt)
        
    def add_mol_to_sp(self, molecule, sp, L):    
        print(molecule, sp, L)
        txt = '\
        MATCH (sp) WHERE sp.name="'+sp+'"\
        MERGE (m:molecule {name:"'+molecule+'"})\
        MERGE (sp)-[:has {L:'+str(L)+'}]->(m)'
        self.push_transaction(txt)

    def db_addchild(self, parent_name, child_rank, child_name):
        txt = ('MATCH (p) WHERE p.name="'+parent_name+'"'\
              'CREATE (c:'+child_rank+'{name:"'+child_name+'"})-[:parent]->(p)')
        self.push_transaction(txt)

    def load_locations(self, path):
        
        '''
        /!\ WIP : neo4j path and os path are different, need fix
        
        x, size  = size_divisor(os.path.getsize(path))
        proceed = input("Loading csv of size : " + str(round(x, 1)) + size + "\nDo you want to proceed ? Y/N\n").lower()
        if not confirm(proceed):
            print("Abort load")
            return 0
        '''
        
        txt = '\
        USING PERIODIC COMMIT 250\
        LOAD CSV WITH HEADERS FROM "'+path+'" AS line\
        MATCH (s:species {name:line.name})\
        WHERE line.name IS NOT NULL AND line.longitude IS NOT NULL AND line.latitude IS NOT NULL AND line.depth IS NOT NULL\
        CREATE (l:location {longitude:toFloat(line.longitude), latitude:toFloat(line.latitude), depth:toFloat(line.depth)})\
        CREATE (l)<-[:at]-(s)'
        self.push_transaction(txt)


    def score(self, select):
        test_score = '\
        WITH s LIMIT 1\
        MATCH (m:molecule)-[:haseffect]->()-[:haseffect]->(prop:property), p=shortestpath((m)-[*..10]-(s))\
        WHERE NONE (r IN relationships(p) WHERE type(r)= "at" OR type(r)="haseffect")\
        WITH DISTINCT prop, p, m, s \
        WHERE (m)-[*..2]->(prop)\
        WITH distinct prop, sum(1.0/toFloat(length(p)^2)) as summed_d_score, s\
        WITH s, prop.name+"_score" as dynamicKey, summed_d_score as dynamicValue\
        WITH s, apoc.map.fromValues([dynamicKey, dynamicValue]) AS map\
        RETURN map'
        count_select = "RETURN count(s)"
        
        count = self.push_transaction(select+count_select).single()[0]
        timing = self.time_transaction(select+test_score)[1]
        
        proceed = input("\
        It takes "+ str(timing)+"ms to complete scoring for 1 selected node\n\
        Estimated completion time for your selection : " + str(count*timing) + "ms\n\
        Do you want to proceed ?")
        
        if not confirm(proceed):
            print("Abort scoring")
            return 0
        
        apply_score = '\
        WITH s //LIMIT if you need to test\
        MATCH (m:molecule)-[:haseffect]->()-[:haseffect]->(prop:property), p=shortestpath((m)-[*..10]-(s))\
        WHERE NONE (r IN relationships(p) WHERE type(r)= "at" OR type(r)="haseffect")\
        WITH DISTINCT prop, p, m, s \
        WHERE (m)-[*..2]->(prop)\
        WITH distinct prop, sum(1.0/toFloat(length(p)^2)) as summed_d_score, s\
        WITH s, prop.name+"_score" as dynamicKey, summed_d_score as dynamicValue\
        WITH s, apoc.map.fromValues([dynamicKey, dynamicValue]) AS map\
        SET s += map\
        RETURN s'
        self.push_transaction(select+apply_score)

    def add_cat_to_prop(self, effect, prop):
        txt = '\
        MERGE (e:effect {name:"'+effect+'"})\
        MERGE (p:property {name:"'+prop+'"})\
        MERGE (e)-[:haseffect]->(p)'
        return txt
    
    def build_drug_prop_rel(self):
        for i in DRUGCLASS:
            for j in DRUGCLASS[i]:
                txt = self.add_cat_to_prop(j, i)
                self.push_transaction(txt)


def confirm(x):
    v = x.lower() 
    return v == 1 or v == "y" or v == "yes"

def size_divisor(x):
    s = len(str(x))
    if  9 < s:
        return x/10**9, "Gb"
    elif 6 < s:
        return x/10**6, "Mb"
    elif 3 < s:
        return x/10**3, "Kb"
    else:
        return x, "b"
