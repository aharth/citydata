ldfu.sh -p get-countries.n3 -o countries.nq

rapper -i nquads countries.nq > countries.nt

ldfu.sh -i http://harth.org/andreas/2017/citydata/unsd/countrycodes.ttl countries.nt -q map-eionet-unsd.rq eionet-unsd.nt

cat eionet-unsd.nt >> countries.nt

rapper -i ntriples countries.nt -o turtle > countries.ttl

rm *.nt
rm *.nq
