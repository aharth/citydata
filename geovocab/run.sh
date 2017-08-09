ldfu.sh -p get-gadm.n3 -o gadm-countries.nq

ldfu.sh -p get-nuts.n3 -o nuts-countries.nq

rapper -i nquads gadm-countries.nq > gadm-countries.nt

rapper -i nquads nuts-countries.nq > nuts-countries.nt

ldfu.sh -i http://harth.org/andreas/2017/citydata/unsd/countrycodes.ttl gadm-countries.nt nuts-countries.nt -q map-gadm-unsd.rq gadm-unsd.nt -q map-nuts-unsd.rq nuts-unsd.nt

cat gadm-unsd.nt > countries.nt
cat nuts-unsd.nt >> countries.nt

rapper -i ntriples countries.nt -o turtle > countries.ttl

rm *.nt
