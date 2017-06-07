convertIlluminaHumanHt12v4ToEnsembl <- function(illuminaIds){

    library(biomaRt)
    ensembl=biomaRt::useMart('ENSEMBL_MART_ENSEMBL',
                           dataset = 'hsapiens_gene_ensembl',
                           host='www.ensembl.org')

    genes<-getBM(attributes = c('illumina_humanht_12_v4','ensembl_gene_id','external_gene_name'),
               filters='illumina_humanht_12_v4',
               values=illuminaIds,
               mart=ensembl)
    return(genes)
}
