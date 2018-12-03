from neo4j import GraphDatabase
from molregex import DRUGCLASS

class dbDriver(object):

    def __init__(self, uri, user, password):
        self._driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):
        self._driver.close()

    def push_transaction(self, message):
    '''
    For queries not requiring csv loading, use push_query for those
    '''
        with self._driver.session() as session:
            result = session.write_transaction(self._run, message)
            return result

    def push_query(self, message):
        with self._driver.session() as session:
            session.run(message)    
    
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
        request  = '\
        MATCH (m:molecule) WHERE m.name="'+molecule+'"\
        MERGE (e:effect {name:"'+effect+'"})\
        MERGE (m)-[:haseffect]->(e)'
        self.push_transaction(request )
        
    def add_mol_to_sp(self, molecule, sp, L):    
        print(molecule, sp, L)
        request  = '\
        MATCH (sp) WHERE sp.name="'+sp+'"\
        MERGE (m:molecule {name:"'+molecule+'"})\
        MERGE (sp)-[:has {L:'+str(L)+'}]->(m)'
        self.push_transaction(request )

    def db_addchild(self, parent_name, child_rank, child_name):
        request  = ('MATCH (p) WHERE p.name="'+parent_name+'"'\
              'CREATE (c:'+child_rank+'{name:"'+child_name+'"})-[:parent]->(p)')
        self.push_transaction(request )

    def load_species_locations(self, path):
        
        '''
        /!\ WIP : neo4j path and os path are different, need fix
        
        x, size  = size_divisor(os.path.getsize(path))
        proceed = input("Loading csv of size : " + str(round(x, 1)) + size + "\nDo you want to proceed ? Y/N\n").lower()
        if not confirm(proceed):
            print("Abort load")
            return 0
        '''
        
        request  = '\
        USING PERIODIC COMMIT 250\
        LOAD CSV WITH HEADERS FROM "'+path+'" AS line\
        MATCH (s:species {name:line.name})\
        WHERE line.name IS NOT NULL AND line.longitude IS NOT NULL AND line.latitude IS NOT NULL AND line.depth IS NOT NULL\
        CREATE (l:location {longitude:toFloat(line.longitude), latitude:toFloat(line.latitude), depth:toFloat(line.depth)})\
        CREATE (l)<-[:at]-(s)'
        self.push_query(request )

    def load_env_map(self, name, res, path):
        create_map = '\
        CREATE (m:map {name:"'+name+'")'
        
        create_constraint = 'CREATE CONSTRAINT ON (m:map) ASSERT m.name IS UNIQUE'
        build_csv  = '\
        LOAD CSV WITH HEADERS FROM "'+path+'" AS line\
        WITH toFloat(line.latitude) as x, toFloat(line.longitude) as y, toFloat('+res+')/2.0 as r, line\
        CREATE (pixloc:pixel_location)\
        SET pixloc += line\
        WITH x, y, r\
        MATCH (loc:location), (m:map {name:"'+name+'"})\
        WHERE x-r<loc.longitude<x+r AND y-r<loc.latitude<y+r\
        CREATE (m)<-[:within]-(pixloc)<-[:at]-(loc)'        
        self.push_transaction(create_map)
        self.push_transaction(create_contraint)
        self.push_query(build_csv)

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
        request  = '\
        MERGE (e:effect {name:"'+effect+'"})\
        MERGE (p:property {name:"'+prop+'"})\
        MERGE (e)-[:haseffect]->(p)'
        return request 
    
    def build_drug_prop_rel(self):
        for i in DRUGCLASS:
            for j in DRUGCLASS[i]:
                request  = self.add_cat_to_prop(j, i)
                self.push_transaction(request )

    
    def fetch_all_molecules(self):
        request = "MATCH (m:molecule)\
        RETURN collect(m.name)"

        result = self.push_transaction(request)
        molecules = result.single()[0]        
        return molecules
    
    def fetch_molecules_info(self):
        '''
        Returns a list of list like this : [ [molecule, [[specie1, proba_of_presence], [specie2, proba_of_presence]...], [effect1, effect2, ...]], ... ]
        '''
        request = "MATCH (m:molecule)<-[r:has]-(x)\
        OPTIONAL MATCH (e:effect)<-[:haseffect]-(m)\
        WITH DISTINCT m, [x.name, r.L] as sp, e\
        WITH DISTINCT m, collect(sp) as species, collect(e.name) as effects\
        RETURN [m.name,species,effects]"

        result = self.push_transaction(request)
        molecules_info = result.single()[0]        
        return molecules_info
    
    def fetch_mol_locations(self, molecule, proba):
        request  = '\
        MATCH (m:molecule)<-[r1:has]-()<-[:parent *..2]-()-[r2:at]->(loc:location) \
        WHERE m.name="' +mol_name+ '"\
        AND ( (NOT exists(r2.L) AND r1.L>' +str(proba)+ ') OR (exists(r2.L) AND r1.L*r2.L>' +str(proba)+')) \
        RETURN collect([loc.longitude, loc.latitude])'
        result = self.push_transaction(request )
        locations = result.single()[0]
        return locations
    
    def fetch_species_at_location(self, origin, extent):
        xo, yo = origin
        xe, ye = origin+extent
        request  = '\
        MATCH (loc:location)<-[:at]-(x) \
        WHERE '+str(xo)+'<=loc.longitude<='+str(xe)+' AND '+str(yo)+'<=loc.latitude<='+str(ye)' \
        WITH DISTINCT loc, collect(x.name) AS species \
        RETURN collect([[loc.longitude, loc.latitude], species])'
        result = self.push_transaction(request )
        result = result.single()[0]
        return result
        


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
