import tools
import argparse
from sqlalchemy import create_engine

parser = argparse.ArgumentParser(description='Process some networks')
parser.add_argument('-f','--file', help='file to dump in sql', required=True)
parser.add_argument('-n','--name', help='name of sql table', required=True)
parser.add_argument('--sql_endpoint', default="root@localhost/pharmap")
parser.add_argument('--force', action='store_const', const=True, help="erase table if exist", default=False )
parser.add_argument('--chunk', type=int, help="Number check done at once", default=1000)
parser.add_argument('--header', type=int, help="header to skip in the choosen file", default=0)
args = parser.parse_args()

engine = create_engine('mysql+pymysql://' + args.sql_endpoint, echo=False)
df = tools.simpleLoad(args.file, args.header)

behavior = "fail"
if (args.force):
    behavior = "replace"

df.to_sql(args.name, engine, if_exists=behavior, chunksize=args.chunk)