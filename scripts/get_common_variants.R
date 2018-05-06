#!/usr/bin/env R

library('plyr')
library('optparse')

args <- commandArgs(TRUE)

read_file_df <- function(fileName){
  df <- read.delim(fileName, sep = '\t')
  df$POS <- as.numeric(as.character(df$POS))
  df$ALT <- as.character(df$ALT)
 return(df)
}
all_dfs <- lapply(args, read_file_df)

prev = all_dfs[[1]]
# for each dataframe ... take only the variants that appear in the df before it
  # continuously filter variants that appear
for (df in all_dfs[c(2:length(all_dfs))]){
  prev_SNVs <- c(c(prev$POS), c(prev$ALT))
  df_SNVs <- c(c(df$POS), c(df$ALT))
  rows <- sapply(df_SNVs, function(x, prev){x %in% prev},prev = prev_SNVs)
  consensus <- df[rows,]
  prev <- consensus
 }
 consensus <- consensus[complete.cases(consensus),]

write.table(consensus,file="common_variants.txt",quote=FALSE, sep='\t', row.names=FALSE)
