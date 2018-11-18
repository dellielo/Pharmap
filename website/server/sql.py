import sqlalchemy
from sqlalchemy.orm import sessionmaker
import os

if (not os.environ['SQL_ENDPOINT']):
    raise NameError("No SQL_ENPOINT in environment")

engine = sqlalchemy.create_engine('mysql+pymysql://' + os.environ['SQL_ENDPOINT'], isolation_level="READ COMMITTED")

Session = sessionmaker(bind=engine, autoflush=False, autocommit=False)
session = Session()
session.flush = lambda: print('No writing allowed') #make db read only

selectedId = 'species_id'
mapTableName = "map"

row2dict = lambda r: {c.name: str(getattr(r, c.name)) for c in r.__table__.columns}

def resultProxyToArray(resultproxy):
    d, a = {}, []
    for rowproxy in resultproxy:
    # rowproxy.items() returns an array like [(key0, value0), (key1, value1)]
        for tup in rowproxy.items():
            # build up the dictionary
            d = {**d, **{tup[0]: tup[1]}}
        a.append(d)
    return a

def getSpeciePredict(specieId, lattitudeMin, lattitudeMax, longitudeMin, longitudeMax):
    query = "SELECT * FROM {} WHERE {} = {} and latitude >= {} and latitude <= {} and longitude >= {} and longitude <= {}".format(
        mapTableName, selectedId, specieId, lattitudeMin, lattitudeMax, longitudeMin, longitudeMax)
    result = session.execute(query)
    tab = resultProxyToArray(result)
    result.close()
    return tab