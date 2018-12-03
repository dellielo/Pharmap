import factory
import tools
import sys
import os
import argparse



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--dir', '-f', help="Directory path", type= str)
    parser.add_argument('--xo', '-x', help="Longitude of origin", type= float, default= 0)
    parser.add_argument('--yo', '-y', help="Latitude of origin", type= float, default=0)
    parser.add_argument('--ex', '-l', help="Length, number of pixel in x", type= int, default=0)
    parser.add_argument('--ey', '-w', help="Width, number of pixel in y", type= int, default=0)
    parser.add_argument('--res', '-r', help="Resolution in degre of pixels", type= float, default=1)
    parser.add_argument('--output', '-o', help="Output as", type= str, default="~/output.csv")
    args=parser.parse_args()
    df = factory.build_environment_dataframe(origin=(args.xo, args.yo), extent=(args.ex, args.ey), res=args.res, dir_path=args.dir)
    tools.save_out_csv(tab=df, dirname = tools.getpath(args.output), filename= os.path.basename(args.output))
    print("Successfully created environment csv")
