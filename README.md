# Zweifelab Kanamycin-resistant Yeast
Code for parsing and processing SNVs in kanamycin-resistant yeast from the Zweifelab. 
## Output
* Files describing SNVs located within CDSs for each sample
* Files describing annotations for ORFs with SNVs (by sample and for SNVs present in all samples)
## Data
* Original .vcf and .gff files for each sample and the reference, respectively
* CDS file for the reference
## Scripts
R and python scripts used to...
  * Match .vcf and .gff coordinates
  * Get SNVs that are within CDSs
  * Output those SNVs and their annotations
## Dependencies
* optparse (R)
