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
assin)"


REG = re.compile("[a-zA-Z0-9--]+{chem}+(( |-)[a-zA-Z0-9--]*{chem}(s)*)*(( |-)[A-Z]?[0-9]*)* ".format(chem = CHEMS))

