# get undata population
ldfu.sh -i ../2017-07-31/undata.nq.gz -q undata-cities-population-construct.rq undata-cities-population-construct.nt.gz

# get eurostat population
ldfu.sh -i ../2017-07-31/eurostat.nt.gz -q eurostat-cities-population-construct.rq eurostat-cities-population-construct.nt.gz

# get geonames population
JAVA_OPTS="-Xmx192G -Xms64G" ldfu.sh -i all-geonames-rdf.nq.gz -q geonames-population-construct.rq geonames-population-construct.nt.gz

# geonames only english labels
zcat geonames-population-construct.nt.gz | grep -e "@en" > gn-labels.nt
zcat geonames-population-construct.nt.gz | grep -ve "#label>" >> gn-labels.nt
gzip gn-labels.nt
mv gn-labels.nt.gz geonames-population-construct.nt.gz

# select population
ldfu.sh -i undata-cities-population-construct.nt.gz -q population.rq undata.tsv
ldfu.sh -i eurostat-cities-population-construct.nt.gz -q population.rq eurostat.tsv
ldfu.sh -i geonames-population-construct.nt.gz -q population.rq geonames.tsv

# remove first line and sort (to get population of last available year)
sed '1d' undata.tsv | sort -u  > undata.1.tsv
sed '1d' eurostat.tsv | sort -u > eurostat.1.tsv
sed '1d' geonames.tsv | sort -u  > geonames.1.tsv

# match
python match-sim.py undata.1.tsv geonames.1.tsv | grep -E "sameAs>|label>" > undata-geo-geonames-links.nt
python match-sim.py eurostat.1.tsv geonames.1.tsv | grep -E "sameAs>|label>" > eurostat-geo-geonames-links.nt

# matches in Turtle
rapper -i ntriples undata-geo-geonames-links.nt -o turtle > undata-geo-geonames-links.ttl
rapper -i ntriples eurostat-geo-geonames-links.nt -o turtle > eurostat-geo-geonames-links.ttl
