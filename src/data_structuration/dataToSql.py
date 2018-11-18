import tools
import argparse
from sqlalchemy import create_engine

parser = argparse.ArgumentParser(description='Process some networks')
parser.add_argument('-f','--file', help='file to dump in sql', required=True)
parser.add_argument('-n','--name', help='name of sql table', required=True)
parser.add_argument('--sql_endpoint', default="mysql+pymysql://root@localhost/pharmap")
parser.add_argument('--force', action='store_const', const=True, help="erase table if exist", default=False )
parser.add_argument('--chunk', type=int, help="Number check done at once", default=1000)
args = parser.parse_args()

engine = create_engine(args.sql_endpoint, echo=False)
df = tools.simpleLoad(args.file, 1)

behavior = "fail"
if (args.force):
    behavior = "replace"

df.to_sql(args.name, engine, if_exists=behavior, chunksize=args.chunk)