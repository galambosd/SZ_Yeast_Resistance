#!/usr/bin/env R
library('plyr')


args <- commandArgs(TRUE)

# file with variants to exclude
to_exclude <- read.delim(file = args[[1]],sep="\t")
# to_exclude$POS <- as.numeric(as.character(to_exclude$POS))
# to_exclude$ALT <- as.character(to_exclulde$ALT)
# exclude_SNVs <- c(c(to_exclude$POS), c(to_exclude$ALT))
# to_exclude_rows <- alply(.data = to_exclude, .margins = 1, .fun = function(x){return(x)})

to_trim <- read.delim(file = args[[2]],sep="\t")
# df_SNVs <- c(c(to_trim$POS), c(to_trim$ALT))

# total <- rbind(to_trim, to_exclude)


trimmed <- to_trim[which(!(to_trim$POS %in% to_exclude$POS)),]

write.table(trimmed,file="unique_variants.txt",sep='\t',row.names=FALSE,quote=FALSE)
