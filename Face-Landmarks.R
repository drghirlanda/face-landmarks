library("readxl")
#all files in the current working directory with .xlsx will be stored in file.list
file.list <- list.files(pattern='*.xlsx')
length <- length(file.list)
for(i in seq(1, length, 4)){

	person1 <- read_excel(file.list[i])
	person2 <- read_excel(file.list[i+1])
	person3 <- read_excel(file.list[i+2])
	person4 <- read_excel(file.list[i+3])
	sdX <- c()
	sdY <- c()
	missing <- c()
	pointNumber <- c(1:31)
	for(num in 1:31){
		pointX <- c(person1[num,3],person2[num,3],person3[num,3],person4[num,3])
		pointY <- c(person1[num,4],person2[num,4],person3[num,4],person4[num,4])
		sdX[num] <- sd(pointX, na.rm=TRUE)
		sdY[num] <- sd(pointY, na.rm=TRUE)
		missing[num] <- sum(is.na(pointX),is.na(pointY))
	}
	finalTable <- data.frame(
	pointNumber,
	sdX,
	sdY,
	missing
	)
	finalTable[] <- lapply(finalTable,round,5)
	fileName <- substring(file.list[i],1,16)
	write.table(finalTable, paste(fileName, ".txt"))
}


