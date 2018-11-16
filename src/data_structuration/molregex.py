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
ocin)"

REG = re.compile("[a-zA-Z0-9α-ωΑ-Ω,-]+{chem}+(( |-)[a-zA-Z0-9--α-ωΑ-Ω,-]*{chem}(s)*)*(( |-)[A-Z]?[0-9]*)* ".format(chem = chems))


DRUGCLASS ={
    'anticancer':["anti-tumour",
                  "apoptotic",
                  "anti-proliferative",
                  "anti-tumor",
                  "anti-cancer",
                  "antineoplastic",
                  "anti-angiogenic",
                  "cytotoxicity", 
                  "cytotoxic",
                  "cytostatic",
                  "growth inhibitor",
                  "growth inhibiting",
                  "immunomodulator",
                  "proteasome inhibitors],                  
    'Nutraceutical':["anti-oxydant",
                   "antioxydative",
                   "anti_obesity",
                   "fats",
                   "glycolipids",
                   "polysaccharide",
                   "steroids"  
                    ],
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
                     "antiamobeic",
                     "antitrematode",
                     "amoebicid",
                     "Plasmodium falciparum"],
    'antifungal':["antifungic",
                  "antifungal"],
    'antiviral':["antiviral",
                 "neuraminidase inhibitor"],
    'anti-inflammatory':["anti-inflammatory",
                         "immunosupressive",
                         "NSAIDs",
                         "NF-κB modulator"],
                         
    'anesthetic/analgesic':["anesthetic", 
                            "analgesic",
                            "pain inhibitor"],
    'psychotropic': ["acetyl-choline receptor agonists",
                     "acetyl-choline receptor antagonists",
                     "anxiolytic",
                     "anxiogenic",
                     "anti-convulsant",
                     "anti-epileptic",
                     "anti-seizure",
                     "anti-beta-amyloid fibrillization",
                     "GABAr-agonist",
                     "glutamate receptor agonists",
                     "glutamate receptor antagonists",
                     "neuroprotective"],
    'cardiovascular': ["alpha-blockers",
                        "angiotensin-receptor blockers",
                        "angiotensin-converting enzyme inhibitor",
                        "antiplatelets",
                        "antithrombotic",
                        "anticoagulant",
                        "antihypertensive",
                        "beta-blockers",
                        "calcium-channel blockers",
                        "diuretics",
                        "hematopoietic"]
                    
                     
}

