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
                  "anti-tumor", 
                  "cytotoxicity", 
                  "cytotoxic", 
                  "growth inhibitor",
                  "growth inhibiting"
                  "anti-cancer", 
                  "antineoplastic",
                  "cytostatic"],
    'antioxydant':["anti-oxydant",
                   "antioxydative"],
    'antibiotic':["bacteriostatic", 
                  "anti-microbial", 
                  "antibiotic", 
                  "bactericide", 
                  "S. aureus"],
    'antiparasitic':["Plasmodium falciparum,
                     "antimalarial",
                     "antiparasitic"
                     "antiprotozoal",
                     "antihelminthic",
                     "anticestode",
                     "antinematode",
                     "antiamobeic",
                     "antitrematode",
                     "amoebicid"],
    'antifungal':["antifungic",
                  "antifungal"],
    'antiviral':["antiviral"],
    'anti-inflammatory':["anti-inflammatory"],
    'anesthetic/analgesic':["anesthetic", 
                            "pain inhibitor",
                            "analgesic"]    
}

