#!/bin/sh

set -x

tarql.sh unsd-methodology.rq > tmp.ttl
rapper -i turtle tmp.ttl -o turtle  | sed -e "s/file:\/\/.*/unsd-methodology#> ./" > unsd-methodology.ttl
rm tmp.ttl

tarql.sh 240.rq > tmp.ttl
cwm -n3 tmp.ttl | sed -e "s/http:\/\/harth.org\/andreas\/2017\/citydata\/unsd\///" > cities.ttl
rm tmp.ttl

tarql.sh 240-proper.rq > tmp.ttl
cwm --n3 tmp.ttl --ntriples > tmp.nt
rapper -i ntriples tmp.nt -o turtle | sed -e "s/http:\/\/harth.org\/andreas\/2017\/citydata\/unsd\///" | sed -e "s/#C/#000001/" | sed -e "s/#U/#000002/"> cities-proper-links.ttl
rm tmp.ttl
rm tmp.nt

sparql "https://query.wikidata.org/sparql" wikidata.rq wikidata.rdf
cwm --rdf wikidata.rdf > wikidata.1.rdf
rapper wikidata.1.rdf -o turtle > wikidata.ttl
rm wikidata.rdf
rm wikidata.1.rdf
