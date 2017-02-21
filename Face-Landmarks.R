library("readxl")
#all files in the current working directory with .xlsx will be stored in file.list
file.list <- list.files(pattern='*.xlsx')
length <- length(file.list)
for(i in seq(1, length, 4)){
  
  person1 <- read_excel(file.list[i])
  person2 <- read_excel(file.list[i+1])
  person3 <- read_excel(file.list[i+2])
  person4 <- read_excel(file.list[i+3])
  
  library(data.table)
  
  xCoordinate <- data.table(x1=person1[,3],x2=person2[,3],x3=person3[,3],x4=person4[,3])
 
  yCoordinate <- data.table(y1=person1[,4],y2=person2[,4],y3=person3[,4],y4=person4[,4])
  
  sdX <- apply(xCoordinate[,c("x1","x2","x3","x4")],1,FUN=sd,na.rm=TRUE)
  sdY <- apply(yCoordinate[,c("y1","y2","y3","y4")],1,FUN=sd,na.rm=TRUE)
  missing <- rowSums(is.na(xCoordinate))+ rowSums(is.na(yCoordinate))
  
  finalTable <- data.table(pointNumber=(1:31), sdX=sdX, sdY=sdY, missing=missing)
  
  fileName <- substring(file.list[i],1,16)
  write.table(finalTable,paste(fileName, ".txt"))
}


