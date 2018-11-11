import re

CHEMS = "(\
amine|\
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
ine|\
ocin)"

REG = re.compile("[a-zA-Z0-9]+{chem}+(( |-)[a-zA-Z0-9--]*{chem}(s)*)*(( |-)[A-Z]?[0-9]*)* ".format(chem = CHEMS))

DRUGCLASS ={
    'anticancer':["anti-tumour",
                  "Apoptotic",
                  "anti-proliferative",
                  "anti-tumor",
                  "anti-cancer",
                  "antineoplastic",
                  "cytotoxicity", 
                  "cytotoxic",
                  "cytostatic",
                  "growth inhibitor",
                  "growth inhibiting",
                  "Immunomodulator"],                  
    'antioxydant':["anti-oxydant",
                   "antioxydative"],
    'antibiotic':["Anti-septic", 
                  "anti-microbial", 
                  "antibiotic",
                  "Anti-tuberculosis",
                  "bactericide",
                  "bacteriostatic",
                  "S. aureus"],
                  
    'antiparasitic':["antimalarial",
                     "antiparasitic",
                     "antiprotozoal",
                     "antihelminthic",
                     "anticestode",
                     "antinematode",
                     "antiamobeic",
                     "antitrematode",
                     "amoebicid",
                     "Plasmodium falciparum"],
    'antifungal':["antifungic",
                  "antifungal"],
    'antiviral':["antiviral"],
    'anti-inflammatory':["anti-inflammatory",
                         "Immunosupressive",
                         "NSAIDs"],
                         
    'anesthetic/analgesic':["anesthetic", 
                            "analgesic",
                            "pain inhibitor"],
    'psychotropic': ["Acetyl-choline receptor agonists",
                     "Acetyl-choline receptor antagonists",
                     "Anxiolytic",
                     "Anxiogenic",
                     "anti-convulsant",
                     "anti-epileptic",
                     "anti-seizure",
                     "anti-beta-amyloid fibrillization",
                     "GABAr-agonist",
                     "Glutamate receptor agonists",
                     "Glutamate receptor antagonists",
                     "neuroprotective"],
    'cardio-vascular': ["Alpha-blokers",
                        "Angiotensin-receptor blokers",
                        "Beta-blokers",
                        "calcium-channel blokers",
                        "Diuretics"]
                    
                     
}

