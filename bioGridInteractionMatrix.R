bioGridInteractionMatrix = function(ids){

  #system('wget http://thebiogrid.org/downloads/archives/Release%20Archive/BIOGRID-3.4.135/BIOGRID-ALL-3.4.135.tab2.zip')

  #system('unzip BIOGRID-ALL-3.4.135.tab2.zip')
  require(synapseClient)
  synapseLogin()
  foo <- synGet('syn5987187')
  #system(paste0('unzip ',foo@filePath))

  library(data.table)
  #foo <- fread('BIOGRID-ALL-3.4.135.tab2.txt',data.table=F)
  foo <- fread(foo@filePath,data.table=F,stringsAsFactors=F)
  keep <- which(foo$`Organism Interactor A`=='9606' & foo$`Organism Interactor B`=='9606')
  foo <- foo[keep,]
  #source("https://bioconductor.org/biocLite.R")
  #biocLite("biomaRt")
  library(biomaRt)
  ensembl=biomaRt::useMart('ENSEMBL_MART_ENSEMBL',
                           dataset = 'hsapiens_gene_ensembl',
                           host='www.ensembl.org')

  genes<-getBM(attributes = c('ensembl_gene_id','external_gene_name','entrezgene'),
               filters='ensembl_gene_id',
               values=ids,
               mart=ensembl)
  genes2 <- genes$ensembl_gene_id
  names(genes2) <- genes$entrezgene
  ppi <- matrix(0,length(ids),length(ids));
  colnames(ppi) <- ids
  rownames(ppi) <- ids
  for (i in 1:nrow(foo)){
    if(i%%100==0){
      cat(i,'\n')
    }
    gene1 <- foo$`Entrez Gene Interactor A`[i]
    gene2 <- foo$`Entrez Gene Interactor B`[i]
    egene1 <- genes2[gene1][1]
    egene2 <- genes2[gene2][1]
    if(!is.na(egene1) & !is.na(egene2)){
      ppi[egene1,egene2] <- 1
      ppi[egene2,egene1] <- 1
    }
  }
  return(ppi)
}
