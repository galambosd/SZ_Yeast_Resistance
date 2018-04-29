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
contigs_list <- as.numeric(as.character(gff_contigs_df$V5))
names(contigs_list) <- gff_contigs_df$V1

# The contigs list shows how much to add to the coordinates
contigs_to_add <- c(1:length(contigs_list))
for (i in c(2:length(contigs_list))){
  contigs_to_add[i] <- sum(contigs_list[c(1:i-1)])
 }
contigs_to_add[1] <- 0
names(contigs_to_add) <- names(contigs_list)

# make a separate df with all the real data (not contigs summary or sequence)
orf_df <- subset(gff_master, gff_master$V2 == 'AGAPE')
orf_df <- subset(orf_df, orf_df$V3 == 'gene')

# Make a dictionary with the ID mapping to the length of the contig
# write a function to convert coordinates by adding up lengths of all previous contigs

convert_coords <- function(coords){
  new_row[,4] <- as.numeric(as.character(row[,4])) + contigs_to_add[factor(row[,1])]
  new_row[,5] <- as.numeric(as.character(row[,5])) + contigs_to_add[factor(row[,1])]
 return(new_row)
}

# orf_df$4 <- lapply(orf_df$4,convert_coords,1,)


for (i in c(1:10)){
  orf_df[i,4] <- as.numeric(as.character(orf_df[i,4])) + contigs_to_add[factor(orf_df[i,1])]
  orf_df[i,5] <- as.numeric(as.character(orf_df[i,5])) + contigs_to_add[factor(orf_df[i,1])]
 }
# orf_df$V4 <- as.numeric(as.character(orf_df$V4))+contigs_to_add[factor(orf_df$V1)]
# orf_df$V5 <- as.numeric(as.character(orf_df$V5))+contigs_to_add[factor(orf_df$V1)]

contigs_to_add
orf_df

# How well does it match up to VCF file?


# filter/make sense of vcf file


# go through the vcf file and output all snvs to a text file?
# first, transfer output info to dataframe
# enable transition to only outputting snvs that appear in a gene
# in all 4 strains
# keep in mind that different genes could be causing resistance
# in the 4 strains
