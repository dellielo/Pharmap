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
                  "proteasome inhibitor],                  
    
    'antibiotic':["anti-septic", 
                  "anti-microbial", 
                  "antibiotic",
                  "anti-tuberculosis",
                  "anti-MRSA",
                  "anti-biofilm",
                  "bactericide",
                  "bacteriostatic",
                  "S. aureus"],
                  
    'antiparasitic':["antimalarial",
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
                  
    'antifungal':["antifungic",
                  "antifungal"],
                  
    'antiviral':["antiviral",
                 "neuraminidase inhibitor",
                 "reverse-transcriptase inhibitor"],
                  
    'anti-inflammatory':["anti-inflammatory",
                         "immunosuppressive",
                         "NSAIDs",
                         "NF-κB modulator"],
                         
    'anesthetic/analgesic':["anesthetic", 
                            "analgesic",
                            "pain inhibitor"],
    
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
                  
     'psychotropic': ["acetyl-choline receptor agonist",
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
                      "neuroprotective"]
                    
                     
}

