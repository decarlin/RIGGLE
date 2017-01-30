source("http://bioconductor.org/biocLite.R")
biocLite("limma")
library("Biobase")

exprsFile<-'/cellar/data/Novershtern/data_standard_t.tab'

exprs <- as.matrix(read.table(exprsFile, header=TRUE, sep="\t",
                              row.names=1,
                              as.is=TRUE))

minimalSet <- ExpressionSet(assayData=t(exprs))

meta<-read.table('/cellar/data/Novershtern/sample_descriptions.txt', header=FALSE, sep = "\t", na.strings='NA')


graph<-read.table('/cellar/data/Novershtern/cell_type_graph.sif', header=FALSE, sep="\t", na.strings='NA')

dat.mat<-as.matrix(dat[,2:dim(dat)[2]])

cell_type<-factor(meta$V2)
names(cell_type)<-meta$V1

for (i in 1:dim(graph)[1])
{
	upstream_type=graph[i,1]
	downstream_type=graph[i,3]

	upstream_samples=meta[meta[,2] %in% upstream_type,1]
	downstream_sampels=meta[meta[,2] %in% downstream_type,1]

	d=cbind(as.numeric(meta[,2] %in% upstream_type), as.numeric(meta[,2] %in% downstream_type))

	fit <- lmFit(minimalSet, d)
}