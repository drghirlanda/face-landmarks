data <- read.csv("FaceDataSummary.csv") 

AU <- data[,2]
SU <- data[,4]
sdX <- as.matrix(Symmetry[,2])

cor.test(AU,sdX)
cor.test(SU,sdX)
