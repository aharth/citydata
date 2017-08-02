../linked-data-fu-0.9.10/bin/ldfu.sh -p http://harth.org/andreas/2017/ocdp/ecdp_estatwrap.n3 -o eurostat.nq -v 2> eurostat.log

#!/bin/bash

./linked-data-fu/bin/ldfu.sh -p http://harth.org/andreas/2017/ocdp/programs/get-eurostat.n3 -p http://harth.org/andreas/2017/ocdp/programs/get-qb.n3 -p http://harth.org/andreas/2017/ocdp/programs/qb-norm.n3 -o eurostat.nq.gz -v 2> eurostat-stderr > eurostat-stdout


$ roqet cities-eurostat.rq -r turtle > cities-eurostat.ttl

$ roqet cities-undata.rq -r turtle > cities-undata.ttl

$ roqet cities-undata-select.rq -r tsv > cities-undata-select.tsv

$ ldfu.sh -p get-cities.n3 -i ../queries/cities-eurostat.ttl

$ ldfu.sh -p get-cities.n3 -i ../queries/cities-undata.ttl -o ../queries/cities-undata-dbpedia.nq



$ roqet eurostat-cities-select.rq -r tsv > eurostat-cities-select.tsv

OpenRefine

first match country
then match city (including country)

Reconcile > match each cell to its best candidate

Add column based on this column
cell.recon.match.id

$ tarql.sh eurostat-sameas-wikidata.rq > ../links/eurostat-cities-wikidata-links.ttl 


$ ldfu.sh -p get-cities.n3 -i ../links/eurostat-cities-wikidata-links.ttl -o ../data/cities-wikidata.nq.gz
