import tools
import config
import pandas as pd
import numpy as np
import urllib
import json
from addTaxonomy import fetchID, fetchTaxonomy
from molregex import REG

#
# Don't USE yet
#

def fetchDict(page):
    article_titles = page.find_all("a", attrs={"class":u"title-link"})
    '''
    Returns a dict of species, the molecules found within, and the paper abstract from the article title (Beautiful Soup object)
    '''
    
    vocab = ("sponge", "porifera","seapen", "anthozoa", "palythoa", "polyp", "anemone", "gorgonian", "coral")
    rankid = (1267, 558)
    
    sp_dict = {}

    for paper in article_titles:
        good = False
        abstract = paper.parent.find("div", attrs = {'class':u'abstract-full'})
        splits= abstract.text.lower().split(" ")
        for bit in splits:
            for word in vocab:
                if word in bit: #does it talk about our stuff ?
                    good = True

        if good:
            species = abstract.find_all("i", class_=False) #let's find species in italics
            if species:
                print(species)
                for sp in species:
                    ID = fetchID(sp.text)
                    try:
                        taxonomy = fetchTaxonomy(ID)
                        if taxonomy['phylum']['id'] in rankid:
                            select_mol = set([i.group().lower() for i in REG.finditer(abstract.text)]) #lets make a list of the molecules listed in the paper
                            sp_dict[sp.text]= {paper.text:{"molecules":select_mol,"abstract":abstract.text}}
                    except:
                        print("Couldn't find name in database, resuming \n")
                        pass
    return sp_dict

def getArticles(page):
    return page.find_all("a", attrs={"class":u"title-link"})    

def getLinks(**kwargs):
    contains = kwargs.get("contains", None)
    outlinks_list = kwargs.get("outlinks", list())
    links = set()
    for outlinks in outlinks_list:
        for item in outlinks:
            url = item.find('a', href=True)
            #print(url['href'])
            if contains in url["href"]:
                links.add(url['href'])
    return(links)

def findGoodLinks(local_soup):
    links = set()
    outlinks_list  = local_soup.find_all("li", attrs={'class':'side-menu-li'})
    outlinks_issue = local_soup.find_all("div", attrs={'class':'issue-cover'})
    outlinks_oldissues = local_soup.find_all("li", attrs={'class':None})
    
    links.update(getLinks(outlinks=[outlinks_list, outlinks_issue, outlinks_oldissues], contains="1660"))
    return links


def crawl(**kwargs):
    '''
    This functions crawl through articles
    
    Arguments
    start = str  url_starting point
    depth = int  depth of crawl
    output_method = str choose a filetype for saving (pickles, dill, txt, json)
    output = str writes output to this directory
    
    TODO: Finish the function to check for valid molecules and make a global dictionnary
    
    '''
    domain= kwargs.get("domain", 'https://www.mdpi.com')
    start = kwargs.get("start", '/1660-3397/15')
    depth = kwargs.get("depth", 1)
    output_method = kwargs.get("output_method", None)
    output = kwargs.get("output", None)
    visited = kwargs.get("visited", set())
    runlenght = kwargs.get("runlength", 10)
    
    page = BeautifulSoup(urllib.request.urlopen(domain+start))
    links = findGoodLinks(page)
    new_links = set()
    c = 0
    while links and c <= runlenght:
        c += 1
        
        href = links.pop() #Following lines update the crawler visited/tovisit status
        visited.add(href)

        page = BeautifulSoup(urllib.request.urlopen(domain+href)) #Now open the page and add all unseen links to set
        try:
            newlinks = findGoodLinks(page)  
            for link in newlinks:
                if link not in visited:
                    links.add(link)
        except:
            print("Couldn't open page " + href +" resuming...\n")
            pass
                
        try:
            page_dict = fetchDict(page)
            #print(str(page_dict)[:2000]+"\n\n")
        except:
            print("No article there, resuming...\n")
            pass
