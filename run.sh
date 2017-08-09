#!/bin/bash

set -x

http_proxy="http://proxy.kit.edu:3128/"
export http_proxy

date=`date -I`

mkdir -p $date

for i in eurostat undata ; do
    # crawl
    JAVA_OPTS="-Xmx64G -Dldfu.http.connecttimeout=60000 -Dldfu.http.sockettimeout=60000 -Dldfu.inputoriginthreads=1 -Dldfu.processingthreads=4" ldfu.sh -p http://harth.org/andreas/2017/citydata/programs/get-${i}.n3 -p http://harth.org/andreas/2017/citydata/programs/get-qb.n3 -p http://harth.org/andreas/2017/citydata/programs/qb-norm.n3 -o ${date}/${i}-crawl.nq -v 2> ${date}/${i}-crawl.log
    # parse to clean files
    rapper -i nquads ${date}/$i-crawl.nq -o nquads 2> ${date}/${i}-parse.log | gzip -c > ${date}/$i-crawl-clean.nq.gz
    # query observation values
    JAVA_OPTS="-Xmx64G" ldfu.sh -i ${date}/${i}-crawl-clean.nq.gz -q queries/observations-value.rq ${date}/${i}-obs-crawl.csv
    # map crawl to canonical representation
    JAVA_OPTS="-Xmx64G" ldfu.sh -p http://harth.org/andreas/2017/citydata/programs/map-${i}.n3 -i ${date}/${i}-crawl-clean.nq.gz -o ${date}/${i}.nq -v 2> ${date}/${i}-map.log
    # parse to clean files
    rapper -i nquads ${date}/$i.nq | gzip -c > ${date}/$i.nt.gz &
    # query for observations in materialised data
    JAVA_OPTS="-Xmx64G" ldfu.sh -i ${date}/${i}.nq -q queries/observations.rq ${date}/${i}-obs-mat.csv
    # generate global cube (observations in canonical representation)
    JAVA_OPTS="-Xmx64G" ldfu.sh -i ${date}/${i}.nq -q queries/observations-${i}-construct.rq ${date}/global-cube-${i}.nt
    # skolemise blank nodes
    sed -e "s/_:\(\S*\)/<http:\/\/skol\/\1>/g" ${date}/global-cube-${i}.nt > ${date}/global-cube-${i}.1.nt
    mv ${date}/global-cube-${i}.1.nt ${date}/global-cube-${i}.nt
    gzip ${date}/global-cube-${i}.nt &
done

sleep 10s
gzip ${date}/*.nq
