# Andreas Harth 2017
import difflib
import csv
import sys

# convert string to integer (population should really be integer)
def num(s):
    try:
        return int(s)
    except ValueError:
        return int(float(s))

#### check command line arguments

debug = False

if len(sys.argv) == 4:
    debug = True

if len(sys.argv) != 3 and len(sys.argv) != 4:
    print "USAGE: python match-sim.py source-file target-file debug"
    print sys.argv
    sys.exit()

ffrom = open(sys.argv[1], "r")
ftarget = open(sys.argv[2], "r")

ffrom = csv.reader(ffrom, delimiter='\t')
ftarget = csv.reader(ftarget, delimiter='\t')

#### load input file from

namesfrom = {}
yearsfrom = {}
popsfrom = {}
areasfrom = {}

for row in ffrom:
    uri = row[0]
    name = row[1].lower() # unicode(row[from])

    if row[2] != '':
        year = int(row[2]) # to integer
    else:
        if debug:
            print "no year for ", uri

    if row[3] != '':
        pop = num(row[3]) # to integer
    else:
        if debug:
            print "no pop for " , uri

    if row[4] != '':
        area = row[4]
    else:
        if debug:
            print "no area for " , uri

    namesfrom[uri] = name
    yearsfrom[uri] = year
    popsfrom[uri] = pop
    areasfrom[uri] = area

#print names
#print years
#print pops

ifrom = len(popsfrom.keys())

#### load input file target

namestarget = {}
yearstarget = {}
popstarget = {}
areastarget = {}

for row in ftarget:
    uri = row[0]
    name = row[1].lower() # unicode(row[target])

    if row[2] != '':
        year = int(row[2]) # to integer
    else:
        if debug:
            print "no year for " , uri

    if row[3] != '':
        pop = num(row[3]) # to integer
    else:
        if debug:
            print "no pop for " , uri

    if row[4] != '':
        area = row[4]
    else:
        if debug:
            print "no area for " , uri

    namestarget[uri] = name
    yearstarget[uri] = year
    popstarget[uri] = pop
    areastarget[uri] = area

#print names
#print years
#print pops

itarget = len(popstarget.keys())

#### print stats of input files

print sys.argv[1], ffrom, ifrom
print sys.argv[2], ftarget, itarget

keysfrom = popsfrom.keys()
keystarget = popstarget.keys()

if debug:
    print "######## from"
    for key in keysfrom:
        print key, namesfrom[key], yearsfrom[key], popsfrom[key]

    print "######## target"
    for key in keystarget:
        print key, namestarget[key], yearstarget[key], popstarget[key]

# create lists
candidates = {}
for idfrom in keysfrom:
    candidates[idfrom] = list()

# threshold (+- 5 %)
threshold = 0.05

# first generate candidates based on area and population
for idfrom in keysfrom:
    pop = popsfrom[idfrom]
    area = areasfrom[idfrom]

    for idtarget in keystarget:
        # only consider cities in same country
        if area == areastarget[idtarget]:
            if pop*(1-threshold) < popstarget[idtarget] and pop*(1+threshold) > popstarget[idtarget]:
                # print "Match", idfrom, idtarget

                # append to the list of identifiers
                candidates[idfrom].append(idtarget)

#            if idfrom != idtarget:
#                print "Clash", idfrom, idtarget

# second, check similarity for label ofx candidates
#print candidates

for key in candidates:
    idlitarget = candidates[key]
    if len(idlitarget) > 0:
        namesli = list()
        for id in idlitarget:
            namesli.append(namestarget[id])

        #print namesli

        # CONSTANT HERE: 0.7
        match = difflib.get_close_matches(namesfrom[key], namesli, 1, 0.8)

        if len(match) > 0:
            print "match", namesfrom[key], "to", match[0]
            index = namesli.index(match[0])
            keytarget = idlitarget[index]
            print "<"+keytarget+">", "<http://www.w3.org/2002/07/owl#sameAs>", "<"+key+">", "."
            print "<"+keytarget+">", "<http://www.w3.org/2000/01/rdf-schema#label>", "\""+namestarget[keytarget]+"\" ."
            print "<"+key+">", "<http://www.w3.org/2000/01/rdf-schema#label>", "\""+namesfrom[key]+"\" ."
        else:
            print "no match for", key
    else:
        print "empty candidates for ", key
