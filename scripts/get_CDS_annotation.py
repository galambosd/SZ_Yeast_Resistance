import argparse as ap

parser = ap.ArgumentParser(description='A script to get CDS annotations given a list of genes and a CDS file.')
parser.add_argument('-g','--genes',metavar='GENES',type = ap.FileType('r'),help='A list of genes for which to get annotations.')
parser.add_argument('-c','--CDS', metavar='CDS',type = ap.FileType('r'),help='A CDS file with annotations.')
parser.add_argument('-o','--outfile', metavar = 'OUTFILE', type = ap.FileType('w'),help = 'The name of the outfile listing genes and annotations.')

args=parser.parse_args()

gene_list=[]
for line in args.genes.readlines():
    gene = line.rstrip('\n')
    gene_list.append(gene)

CDS_dict = {}
for line in args.CDS.readlines():
    if '>' in line:
        splits = line.split(' ', maxsplit=1)
        descrip = splits[1]
        gene_split = splits[0].split('_')
        gene_name = gene_split[0].lstrip('>')
        CDS_dict[gene_name] = descrip

args.CDS.close()
args.genes.close()

for gene in gene_list:
    args.outfile.write(gene+'\t'+CDS_dict[gene])
    # print(gene+' didn\'t exist in the CDS file.')

args.outfile.close()
