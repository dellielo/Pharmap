"" "
ce documment a été crée pour extraire les nom des genres contre lesquelle la librairie 'regular expressions' comparera les resultats de recherche

"" "









import pandas as pd


file = pd.read_csv('porifera_obis_light.csv', sep=';', header=0) #create a dataframe with the first row as a header

genus_f = file.groupby(['genus']).count() # groupby the genus (although it counts all the other columns)

genus_count = genus_f.iloc[:, 0] #extract the grouped genus column

file.to_csv('genus_re', header=None) # create a file wich containes  the genus names and an integer column which is not important

# change the file type to txt and add 'genus' and 'num' as headers manually

file1 = pd.read_txt('genus_re.txt', sep=',', header=0) #load the 'file' already created

file1.drop(['num'], axis=1) # eliminate the id num column that was added unintentionally

file2.to_csv('genusFinal', header=None) #create the final file needed for the re library