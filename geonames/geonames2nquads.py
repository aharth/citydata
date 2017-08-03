# wget "http://download.geonames.org/all-geonames-rdf.zip"
# unzip all-geonames-rdf.zip
# Written 2017 Andreas Harth
import rdflib
import rdflib.term

f = open("all-geonames-rdf.txt", "r")

while True:
    line1 = f.readline().rstrip()
    line2 = f.readline().rstrip()

    if not line1:
        break

    if not line2:
        break

    line1 = line1 + "about.rdf"

    context=rdflib.term.URIRef(line1)
    g=rdflib.ConjunctiveGraph()
    g.parse(data=line2, publicID=context, format="application/rdf+xml")

    print g.serialize(format='nquads')
