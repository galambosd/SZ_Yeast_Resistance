library('optparse')

# write arg parser
option_list <- list(make_option(c("-g","--GFF"),
  help="Path to the GFF file of the reference sequence.",
  metavar="GFF"),make_option(c("-v","--VCF"),
    help="Path to the VCF file of the variant strain.",
    metavar="VCF"))

opt_parser <- OptionParser(option_list=option_list)
args <- parse_args(opt_parser)

# get the gff and vcf file from the command line

gff_master <- read.delim(args$GFF,sep="\ ",header=FALSE)

# make sense of gff file, convert coordinates

# make a separate dataframe for the dictionary
gff_contigs_df <- subset(gff_master, gff_master$V3 == 'contig')
contigs_list <- gff_contigs_df$V5
names(contigs_list) <- gff_contigs_df$V1

# make a separate df with all the real data


# Make a dictionary with the ID mapping to the length of the contig
# write a function to convert coordinates by adding up lengths of all previous contigs
# How well does it match up to VCF file?


# filter/make sense of vcf file


# go through the vcf file and output all snvs to a text file?
# first, transfer output info to dataframe
# enable transition to only outputting snvs that appear in a gene
# in all 4 strains
# keep in mind that different genes could be causing resistance
# in the 4 strains
