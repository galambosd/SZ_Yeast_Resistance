#!/usr/bin/env python

from sys import argv
# written in python2

def slice_genome(genome, old_start, old_stop):
	start = int(old_start)-1
	stop = int(old_stop)
	return(genome[start:stop])

if __name__ == '__main__':
	with open(argv[1]) as ref:
		ref.readline()
		ref = ref.read()

	ref = ref.replace('\n','')
	print argv[1]+' sliced from '+argv[2]+' to '+argv[3]+':'
	print slice_genome(ref,argv[2],argv[3])
