from sys import argv
from slice_gene_genome import slice_genome

coords = []
with open(argv[1]) as coord_file:
	lines = coord_file.readlines()
	for line in lines:
		split = line.split('\t')
		start = split[0]
		stop = split[1].rstrip('\n')
		coords.append((start,stop))


coords = set(coords)
with open(argv[2]) as ref:
	ref.readline()
	ref = ref.read()
        ref = ref.replace('\n','')

for coord in coords:
	print coord[0] + ' to ' + coord[1] 
	print slice_genome(ref, coord[0],coord[1])
