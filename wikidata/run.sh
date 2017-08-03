# get only one link (lowest Wikidata URI)
sparql "https://query.wikidata.org/sparql" wikidata-eurostat-geo.rq wikidata-eurostat-geo.rdf

tarql.sh eurostat-cities-links.rq > eurostat-cities-links.ttl
