#title: "Awesome_db_scan"
#author: "Alka Potdar"
#date: "8/7/2019"

#Scan the post-translational modification (PTM) annotation database of SNPs using "AWESOME" dataset by reading the SNP list to search
#Please note input files to read-in will be supplied by user

#Read in the database-----
ptm_db<-read.csv(file="awesome-all.tsv",colClasses = c(rep("character",5), rep("numeric",10),rep("character",2)),header=TRUE,sep = "\t")
#Use fread in data.table if above is slow to read
head(ptm_db)
str(ptm_db)
ppi_snps<-read.table(file="snps_ppi.txt",header=TRUE,colClasses = "character")
head(ppi_snps)
ptm_ppi_snps<-subset(ptm_db,ptm_db$rsID%in%ppi_snps$dbSNP)
#str(ptm_ppi_snps)
head(ptm_ppi_snps)
write.table(ptm_ppi_snps,file="match_awesome_db_ppi_snps.txt", row.names = FALSE, quote=FALSE)
kable(ptm_ppi_snps)


### All Ubi snps-------
ubi_loss<-subset(ptm_db,ptm_db$Ubi>0)
ubi_gain<-subset(ptm_db,ptm_db$Ubi<0)
str(ubi_loss)
str(ubi_gain)
write.table(ubi_loss,file="ubi_loss.txt",row.names = FALSE)
write.table(ubi_gain,file="ubi_gain.txt",row.names = FALSE)

#map to known IBD SNPs--------
library(readxl)
known<-read_excel("known.xlsx")
str(known)

known_ptm<-subset(ptm_db,ptm_db$rsID%in%known$`ichip_ID`)
str(known_ptm)

write.table(known_ptm,file="known_ptm.txt",row.names = FALSE)