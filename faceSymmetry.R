library("readxl")
#all files that contain ".xlsx" will be stored in file.list
file.list <- list.files(path = "Measurements")

#landmarkTable combines all the excel files into one table
landmarkTable <-NULL
for(file in file.list){
  x <- read_excel(paste0("Measurements/",file))
  landmarkTable <- rbind(landmarkTable,x)
}

library(data.table)

#convert landmarks into data table
landmarkTable <- data.table(landmarkTable)

#Need this for the descriptions
DescTable <- unique(setDT(landmarkTable), by =c("PointNumber","Face"))
#pointNumber and description of point
DescTable <- cbind(DescTable[,1], DescTable[,7])
#removing left or right from description because I will sort the description later on to find matching points
DescTable$Description <- gsub("left|right", " ", DescTable$Description)

#The average value of each X coordinate
meanofX <- landmarkTable[, mean(X,na.rm=TRUE), by=.(PointNumber, Face, FaceSide)][order(Face)]

setnames(meanofX,"V1","meanX")
#remove duplicate values
meanofX <- unique(setDT(meanofX), by = c("Face","PointNumber")) 
#The average value of each Y coordinate
meanofY <-landmarkTable[, mean(Y,na.rm=TRUE), by=.(PointNumber, Face)]
setnames(meanofY,"V1","meanY")

meanTable <- cbind(meanofX[,1:4], meanofY[,3], DescTable[,2])
#convert meanTable from data.frame into data.table
meanTable <- data.table(meanTable)

#finding the midpoint of all matching left and right points
#remove all center points from meanTable
meanTable <- subset(meanTable, FaceSide!="Center")

#sorting the description so that all matching point are together
meanTable <- meanTable[order(Description, Face)]

#find the midpoint for each of matching points (using the x coordinate values)
midpoint <- meanTable[,lapply(.SD,mean),by=c("Description","Face"),.SDcols=4]
#standard deviation of the all midpoints
sdX <- midpoint[, sd(meanX,na.rm=TRUE), by=Face]
setnames(sdX, "V1", "sdX")

sdY <- meanTable[,sd(meanY,na.rm=TRUE),by=Face][order(Face)]
setnames(sdY, "V1", "sdY")

Symmetry <- cbind(sdX[,1:2],sdY[,2])
Symmetry
