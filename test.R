# ped <- data.frame(ID = c(1:10),
#                   MOTHER = c(0, 0, 1, 1, 1, 1, 1, 1, 1, 1),
#                   FATHER = c(0, 0, 2, 2, 2, 2, 2, 2, 2, 2))

ped <- data.frame(ID = c(1:10),
                  MOTHER = c(0, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                  FATHER = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0))

cM = seq(5, 50, 5)
founder.mafs = runif(10, 0.05, 0.5)

source("r/pedigree.format.R")

pedigree.type = "simple"
cM.male = NULL
cM.female = NULL
chromosome.ids = NULL
snp.names = NULL
map.distances = NULL
error.rate = 1e-4
missing.rate = 0.001
xover.min.cM = 0
xover.min.cM.male = 0
xover.min.cM.female = 0
founder.haplotypes = NULL
sample.founder.haplotypes = FALSE
founder.haplotype.count = NULL
save.PLINK = TRUE
PLINK.prefix = NULL
