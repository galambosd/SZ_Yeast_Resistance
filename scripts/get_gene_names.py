gene_list = []
inFile = open('SNV_genes_735540-3.txt')
for line in inFile.readlines()[1:]:
    splits = line.split('\t')
    gene_descrip=splits[5]
    gene_splits = gene_descrip.split(',')
    gene_name = gene_splits[0]
    gene_list.append(gene_name)

gene_list=set(gene_list)

outFile = open('735540-3_genes_SNVS.txt','w')
for gene in gene_list:
    if gene != 'UNDEF':
        outFile.write(gene + '\n')

outFile.close()
