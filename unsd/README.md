The file unsd-methodology.csv comes from a BLOB (?) at https://unstats.un.org/unsd/methodology/m49/overview/.
The city and area identifiers are with leading zeros.

The file 240.csv manualy downloaded from http://data.un.org/Data.aspx?q=city+datamart%5bPOP%5d&d=POP&f=tableCode%3a240 (add columns for city code and area code).
The area identifiers are originally without leading zeros; 240-zeros.py addes leading zeros to area identifier.
