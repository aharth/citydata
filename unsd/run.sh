tarql.sh unsd-methodology.rq > tmp.ttl
rapper -i turtle tmp.ttl -o turtle  | sed -e "s/file:\/\/.*/> ./" > unsd-methodology.ttl
rm tmp.ttl
