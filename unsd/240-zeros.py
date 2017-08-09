import csv
f = open('240.csv', 'rb')
reader = csv.reader(f)
headers = reader.next()

w = open('240.1.csv', 'wb')

csvw = csv.writer(w, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)

print headers

csvw.writerow(headers)

for row in reader:
    if (len(row) > 6):
        #code = int(row[1])
        row[1] = row[1].zfill(3)

        csvw.writerow(row)
    else:
        print "Ignoring ", row

f.close()
w.close()
