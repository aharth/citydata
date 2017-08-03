# get only one link (lowest Wikidata URI)
sparql "https://query.wikidata.org/sparql" eurostat-geo-links.rq eurostat-geo-links.rdf

tarql.sh eurostat-cities-links.rq > eurostat-cities-links.ttl
