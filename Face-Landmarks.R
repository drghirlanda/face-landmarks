library("readxl")
#all files that contain ".xlsx" will be stored in file.list

data.dir <- paste(data.dir,"*xlsx")
file.list <- list.files(data.dir)


landmarkTable <-NULL

for(file in file.list){
  x <- read_excel(file)
  landmarkTable <- rbind(landmarkTable,x)
}

library(data.table)

#convert landmarks into data table
landmarkTable <- data.table(landmarkTable)

# find standard deviation for each point's X coordinate for each face
standardX <- landmarkTable[,sd(X,na.rm=TRUE),by=.(PointNumber,Face)]
setnames (standardX,"V1","sdX")

# find standard deviation for each point's Y coordinate for each face
standardY <- landmarkTable[,sd(Y,na.rm=TRUE), by=.(PointNumber,Face)]
setnames (standardY,"V1","sdY")


missing <- landmarkTable[ , sum(is.na(X),is.na(Y)),by=.(PointNumber,Face)]
setnames (missing,"V1","Missing")

finalTable <- cbind(standardX[,1:3],standardY[,3], missing[,3])

write.table(finalTable, "landmark.txt")

