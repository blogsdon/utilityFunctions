convertSnpsToGenes <- function(rsIds){
  library(biomaRt)
  mart.snp <- biomaRt::useMart("ENSEMBL_MART_SNP",
                               dataset = "hsapiens_snp",
                               host='uswest.ensembl.org')

  getENSG <- function(rs = "rs3043732", mart = mart.snp) {
    results <- getBM(attributes = c("refsnp_id", "ensembl_gene_stable_id","distance_to_transcript"),
                     filters= "snp_filter", values = rs, mart = mart)
    return(results)
  }
  return(getENSG(rsIds))
}
