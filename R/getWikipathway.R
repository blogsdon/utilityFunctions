getWikipathway <- function(id){
  str <- paste0('?fileType=gpml&pwId=',id,'&revision=0')
  httr::parse_url()

  r <- httr::GET("http://webservice.wikipathways.org/getPathwayAs",
           query = list(fileType = "txt",
                        pwId = id,
                        revision = 0))



}
