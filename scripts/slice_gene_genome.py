#!/usr/bin/env python

from sys import argv

with open(argv[1]) as ref:
	ref.readline()
	ref = ref.read()

ref = ref.replace('\n','')

start = int(argv[2])-1
stop = int(argv[3])

print(argv[1]+' sliced from '+argv[2]+' to '+argv[3]+':')
print(ref[start:stop])
