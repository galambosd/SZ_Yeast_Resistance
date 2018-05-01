library('optparse')
library('plyr')

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
names(contigs_list) <- as.character(gff_contigs_df$V1)

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

get_add <- function(x){
 return(contigs_to_add[as.character(x)])
}

to_add <- lapply(orf_df$V1, get_add)

orf_df$V4 <- as.numeric(as.character(orf_df$V4))
orf_df$V5 <- as.numeric(as.character(orf_df$V5))
to_add <- as.numeric(as.character(to_add))

orf_df$V4<- orf_df$V4 + to_add
orf_df$V5<- orf_df$V5 + to_add

# orf_df$V4 <- as.numeric(as.character(orf_df$V4))+contigs_to_add[factor(orf_df$V1)]
# orf_df$V5 <- as.numeric(as.character(orf_df$V5))+contigs_to_add[factor(orf_df$V1)]

# How well does it match up to VCF file?

# filter/make sense of vcf file
vcf_master <- read.delim(args$VCF,sep="\t",header=FALSE, skip = 29)

vcf_master$V2 <- as.numeric(as.character(vcf_master$V2))
vcf_master$V6 <- as.numeric(as.character(vcf_master$V6))

vcf_df <- subset(vcf_master, vcf_master$V6 >= 25)

SNVs <- vcf_df$V2

get_snv_gene <- function(coord){
  target <- subset(orf_df, (orf_df$V5 >= coord) & (orf_df$V4 <= coord))
  return(target)
}

snv_orfs <- lapply(SNVs,get_snv_gene)

vcf_rows <- sapply(snv_orfs,nrow) >0
snv_orfs <- snv_orfs[vcf_rows]

snv_orf_df <- ldply(snv_orfs)
snv_orf_df <- snv_orf_df[,c(1,4,5,7,9)]
vcf_df_to_output <- vcf_df[vcf_rows,c(4:6)]
snv_orf_df
vcf_df_to_output

combined_df <- cbind(snv_orf_df, vcf_df_to_output)

colnames(combined_df) <- c('contig ID', 'start','stop','strand','gene','REF','ALT','qual')

write.table(combined_df,file="SNV_genes.txt",quote=FALSE, sep='\t')
# go through the vcf file and output all snvs to a text file?
# first, transfer output info to dataframe
# enable transition to only outputting snvs that appear in a gene
# in all 4 strains
# keep in mind that different genes could be causing resistance
# in the 4 strains
