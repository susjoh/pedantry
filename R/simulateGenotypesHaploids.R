#' Simulate recombination events in R - output haplotypes
#'
#' This function simulates genotypes within a pedigree, based on centiMorgan map
#' distances. Outputs genotypes as a GenABEL gwaa object.
#' @param haploid.ids vector of IDs to sample haploid genome from
#' @param haploid.parent parent who produced the haploid offspring, "MOTHER" or "FATHER"
#' @param PLINK.prefix default is a randomly generated name.

haploid.ids <- 3:10
haploid.parent <- "MOTHER"
PLINK.prefix <- "../../Collaboration/Philine Feulner/test"

sampleHaploids <- function(haploid.ids, haploid.parent, PLINK.prefix){
  x       <- read.table(paste0(PLINK.prefix, ".ped"))
  x.map   <- read.table(paste0(PLINK.prefix, ".map"))
  x.pheno <- read.table(paste0(PLINK.prefix, ".pheno"), header = T)

  change.ids <- which(x.pheno$id %in% haploid.ids)

  if(haploid.parent == "MOTHER"){
    for(i in seq(7, ncol(x), 2)){
      x[change.ids,i+1] <- x[change.ids,i]
    }
    x.pheno[change.ids, "sex"] <- 0
  }

  if(haploid.parent == "FATHER"){
    for(i in seq(7, ncol(x), 2)){
      x[change.ids,i] <- x[change.ids,i+1]
    }
    x.pheno[change.ids, "sex"] <- 1
  }

  write.table(x      , paste0(PLINK.prefix, ".haplo.ped")  , row.names = F, col.names = F, quote = F)
  write.table(x.map  , paste0(PLINK.prefix, ".haplo.map")  , row.names = F, col.names = F, quote = F)
  write.table(x.pheno, paste0(PLINK.prefix, ".haplo.pheno"), row.names = F, col.names = F, quote = F)


  convert.snp.ped(pedfile = paste0(PLINK.prefix, ".haplo.ped"),
                  mapfile = paste0(PLINK.prefix, ".haplo.map"),
                  outfile = paste0(PLINK.prefix, ".haplo.genabel"),
                  traits = 1, strand = "u",  mapHasHeaderLine = F, bcast = F)


  genabel.geno <- load.gwaa.data(genofile = paste0(PLINK.prefix, ".haplo.genabel"),
                                 phenofile = paste0(PLINK.prefix, ".haplo.pheno"))

  genabel.geno

}

