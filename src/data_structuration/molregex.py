import re
chems = "(\
amine|\
ynones|\
imine|\
mide|\
alin|\
idin|\
icin|\
aldehyde|\
indole|\
acide|\
lide|\
fide|\
cyanate|\
bonate|\
oxide|\
oate|\
toxin|\
aride|\
idine|\
zide|\
enol|\
inol|\
ynol|\
trile|\
inin|\
inine|\
chloride|\
assin|\
ycin|\
spol|\
sterol|\
enoid|\
erin|\
orin|\
ocin)"


REG = re.compile("[a-zA-Z0-9α-ωΑ-Ω,--\(\)\+\-]+{chem}+(( |-)[a-zA-Z0-9--α-ωΑ-Ω,-]*{chem}(s)*)*(( |-)[A-Z]?[0-9]*)* ".format(chem = chems))



DRUGCLASS ={
    
    'anticancer':["anti-tumour",
                  "apoptotic",
                  "anti-proliferative",
                  "anti-tumor",
                  "anti-cancer",
                  "antineoplastic",
                  "anti-angiogenic",
                  "Akt pathway inhibitor",
                  "cytotoxicity", 
                  "cytotoxic",
                  "cytostatic",
                  "cancer prevention",
                  "growth inhibitor",
                  "growth inhibiting",
                  "immunomodulator",
                  "proteasome inhibitor",
		  "ubiquitin activating enzyme inhibitor"],                  
    
    'antibiotic':["H.pylori",
	          "M.tuberculosis",
		  "Micrococcus luteus",
		  "MRSA",
		  "N.gonorrheae",
		  "P.aeruginosa",
		  "S.aureus",
		  "S.pneumoniae",
		  "S.epidermidis",
		  "B.cereus",
		  "B.subtilis",
		  "E.coli",
		  "antibacterial",
		  "bacteriostatic",
		  "anti-biofilm",
                  "bactericide",
		  "antibiotic"],
                  
    'antiparasitic':["A.castellanii",
	             "A.polyphaga",
		     "L.chagasi",
		     "L.donovani",
		     "Leishmania sp",
		     "P.berghei",
		     "P.falciparum",
		     "T.gondii",
		     "antiparasitic",
		     "antimalarial",
                     "antiparasitic",
                     "antiprotozoal",
                     "antihelminthic",
                     "anticestode",
                     "antinematode",
                     "antiamoebic",
                     "antitrematode",
                     "amoebicide",
                     "Plasmodium falciparum",
                     "trypanocidal"],
                  
    'antifungal': ["C.krusei",
		   "C.albicans",
		   "C.neoformans",
		   "antifungal"],
                  
    'antiviral':["antiviral",
                 "neuraminidase inhibitor",
                 "reverse-transcriptase inhibitor",
		 "Coronavirus",
		 "HIV1",
		 "HSV1",
		 "HSV2",
		 "Polio virus",
		 "West nile virus",
		 "varicella-zoster virus"],
                  
    'anti-inflammatory':["anti-inflammatory",
                         "immunosuppressive",
                         "NSAIDs",
                         "NF-κB modulator"],
    
    'cardiovascular': [ "alpha-blocker",
                        "angiotensin-receptor blocker",
                        "angiotensin-converting enzyme inhibitor",
                        "antiplatelets",
                        "antithrombotic",
                        "anticoagulant",
                        "antihypertensive",
                        "anti-atherosclerotic plaque formation",
                        "beta-blocker",
                        "calcium-channel blocker",
                        "diuretic",
                        "hematopoietic"],
                  
    'cosmeceutical': ["photoprotective",
                      "skin protective"],
                  
    'nutraceutical':["anti-oxydant",
                     "antioxydative",
                     "anti_obesity",
                     "fats",
                     "glycolipids",
                     "oil",
                     "polysaccharide",
                     "steroids"],               
                  
     'nervous system modulator' : ["acetyl-choline receptor agonist",
                                   "acetyl-choline receptor antagonist",
                                   "anxiolytic",
                                   "anxiogenic",
                                   "anti-convulsant",
                                   "anti-epileptic",
                                   "anti-seizure",
                                   "anti-beta-amyloid fibrillization",
                                   "GABAr-agonist",
                                   "glutamate receptor agonist",
                                   "glutamate receptor antagonist",
                                   "neuroprotective",
			           "TRPV1 receptor antagonist",
			           "anesthetic", 
                                   "analgesic",
                                   "pain inhibitor"]
}

