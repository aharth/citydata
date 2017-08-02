# Creating Links between Cities

The issue is that cities in UNData and cities in Eurostat are not linked.

## Different Geospatial Levels

Eurostat defines three levels for statistical city data in Urban Audit (http://ec.europa.eu/eurostat/web/cities/spatial-units):

* City (ca. 3100)
* Greater city (ca. 250)
* Functional urban area (ca. 2200)

In http://estatwrap.ontologycentral.com/dic/cities, the identifiers ending with C/C1/C2 seem to denote cities, and the identifiers ending with L1/L2/L3 seem to indicate functional urban areas.

Please note that NUTS regions are different to cities in Urban Audit.
However, there are some mappings in a file "Ttypologies and local information corresponding to NUTS3.xls" between geo, metroreg and cities (http://harth.org/andreas/2017/ocdp/links/eurostat-geo-metroreg-links.ttl, http://harth.org/andreas/2017/ocdp/links/eurostat-cities-geo-links.ttl).

UNData defines three levels for statistical city data (https://www.un.org/en/development/desa/population/publications/pdf/urbanization/the\_worlds\_cities\_in\_2016\_data\_booklet.pdf, page 3):

* City proper (ca. 4300)
* Urban agglomeration (ca. 2000)
* Metropolitan area

However, UNData 240 only has data about City proper and Urban agglomeration.

## Data about Cities

Eurostat provides for each city/greater city/functional urban area a unique identifier together with a label in English.

UNData provides for each city proper/urban agglomeration a unique identifier (Code of City) and a row identifying the resolution (City type: City proper vs. Urban agglomeration).
With these columns, the UNData wrapper could generate a unqiue id for each geospatial entity.
Also, we could get the name of the city from the data.

We also get the population count from both Eurostat and UNData for their cities.
See eurostat-cities-population.rq and undata-cities-population.rq.

So, we would have from both Eurostat and UNData:

* URI
* Label
* Year
* Population

See eurostat-cities-population.csv and undata-cities-population.csv.

## Similarity Measures

Based on Label, Year and Population, we could define a similarity measure.
Together with a threshold, we could then identify geospatial entities which to consider equal.

Missing values would be a problem for defining the similarity measure, as the population data in UNData is sparse.

## Open Questions

* Are there other shared indicators (other than population) between UNData and Eurostat?

Maybe http://estatwrap.ontologycentral.com/id/urb\_clivcon (Living conditions - cities and greater cities) and http://estatwrap.ontologycentral.com/id/urb\_llivcon (Living conditions - functional urban areas)?

http://estatwrap.ontologycentral.com/dic/indic\_ur#:

* DE3001V: Private households (excluding institutional households 
* DE3002I: Proportion of households that are 1-person households
* DE3002V: One person households
* DE3004I: Average size of households
* DE3005I: Proportion of households that are lone-parent households
* DE3005V: Lone parent private households (with children aged 0 to under 18)
* DE3008I
DE3008V
DE3011I
DE3011V
DE3016I
DE3017V
EC3039V
EC3040V
EC3064V
EC3065V
EC3066V
EC3067V
SA1001V
SA1004V
SA1005V
SA1007I
SA1007V
SA1008I
SA1008V
SA1011I
SA1011V
SA1012V
SA1013V
SA1018V
SA1022V
SA1025V
SA1029V
SA1049V
SA1050V
SA1051V
SA3005V

## Quality

The quality of UNData is pretty bad.
Consider data from Eurostat for Brussels (population data per year):

* http://estatwrap.ontologycentral.com/dic/cities\#BE001C1	Bruxelles / Brussel	2014	1183841
* http://estatwrap.ontologycentral.com/dic/cities\#BE001L2	Bruxelles / Brussel	2014	2607961

Versus data from UNData:

* http://citydata.wu.ac.at/resource/56/001510\#000001	BRUXELLES (BRUSSEL)	2011	177307
* http://citydata.wu.ac.at/resource/56/001510\#000002	BRUXELLES (BRUSSEL)	2011	1561395