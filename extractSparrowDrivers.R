extractSparrowDrivers  = function(synId){
  foo <- synGet(synId)
  library(data.table)
  bar <- fread(foo@filePath,data.table=F)

  library(dplyr)
  bar <- dplyr::select(bar,-V1)
  bar <- as.matrix(bar)
  networkVec <- c(bar[which(upper.tri(bar))])
  #pVec <- pchisq(networkVec^2,1,lower.tail=F)
  #pVec<-p.adjust(pVec,method='bonferroni')
  cutoff <- qchisq(0.05/length(networkVec),1,lower.tail=F)

  driverScore <- rowSums((bar+t(bar))^2>=cutoff)
  names(driverScore) <- colnames(bar)
  return(sort(driverScore,decreasing=T))
}
source("https://bioconductor.org/biocLite.R")
biocLite("biomaRt")

library(biomaRt)
ensembl=biomaRt::useMart('ENSEMBL_MART_ENSEMBL',
                         dataset = 'hsapiens_gene_ensembl',
                         host='www.ensembl.org')

genes<-getBM(attributes = c('ensembl_gene_id','external_gene_name'),
             filters='ensembl_gene_id',
             values=names(foo),
             mart=ensembl)
genes[1:5,]
driverScore <- data.frame(ensembl_gene_id=names(foo),driverScore=foo,stringsAsFactors = F)
driverScore2 <- merge(driverScore,genes,by = 'ensembl_gene_id')
driverScore2 <- dplyr::arrange(driverScore2,desc(driverScore))
driverScore2[1:5,]
