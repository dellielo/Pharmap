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

def getSpeciePredict(specieId, lattitudeMin, lattitudeMax, longitudeMin, longitudeMax):
    query = "SELECT * FROM {} WHERE {} = {} and latitude >= {} and latitude <= {} and longitude >= {} and longitude <= {}".format(
        mapTableName, selectedId, specieId, lattitudeMin, lattitudeMax, longitudeMin, longitudeMax)
    result = session.execute(query)
    tab = []
    for row in result:
        tab.append(row)
    result.close()
    return tab