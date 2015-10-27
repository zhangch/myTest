args <- commandArgs(TRUE)
r <- as.character(args[1])
x <- as.integer(args[2])
n <- as.integer(args[3])
tag <- as.character(args[4])

countReads <- function(file,genomeLength,step) {
  outputfile<-paste(file,".out.txt",sep="")
  if(genomeLength>0) {
    count <- c(0)
    alldata <- read.csv(file, header=F, stringsAsFactors=FALSE, sep="\t")
    index <- step
    while(index<=genomeLength+step) {
      count<-c(count, nrow(na.omit(alldata[alldata$V4>(index-step)&alldata$V4<index,])))
      index <- index+step
    }
    count <- count[2:length(count)]
    
    avgReads <- mean(count)
    nor.count <- count/avgReads
    nor.count2 <- count/sum(count)
    ## write(sprintf(var(nor.count), fmt="%.3f"), file=outputfile, append =TRUE)
    write(sprintf(var(nor.count[nor.count!=0]), fmt="%.3f"), file=outputfile, append =TRUE)
    write(sprintf(var(nor.count2[nor.count2!=0]), fmt="%#.4g"), file=outputfile, append =TRUE)
    
    avgReads <- nrow(alldata)/length(count)
	  nor.count <- count/avgReads
	  nor.count2 <- count/sum(count)
	  write(sprintf(var(nor.count), fmt="%.3f"), file=outputfile, append =TRUE)
    write(sprintf(var(nor.count2), fmt="%#.4g"), file=outputfile, append =TRUE)
    
    
	  pdf(paste(file,".pdf",sep=""),width=10,height=5)
	  x <- c(seq(0, genomeLength, by=step))
  	plot(x, count, xlab="Position", ylab="Counts", pch=20)
  	title(file)
  	dev.off()
  
	  ## x <- c(seq(0, genomeLength, by=step))
	  ## count[count==0]=-10
	  ## plot(x, count, xlab="Position", ylab="Counts")
	  ## abline(h=0,col="green")
	  ## title(paste(file, "; Window size:", step, "; Raw variance:",sprintf(var(count), fmt="%.3f"), "; Normalized variance1:", sprintf(var## (nor.count), fmt="%.3f"), "; Normalized variance2:", sprintf(var(nor.count2), fmt="%#.4g"), sep=" "))
	  ## dev.off()
    
  } else {
    print("NA")
    write("NA", file=outputfile, append =TRUE)
  }
  ## outputfile<-paste(file,".out.txt",sep="")
  ## write(tag, file=outputfile, append =TRUE)
  ## write(paste(sprintf(avgReads, fmt="%.3f"), sprintf(var(count), fmt="%.3f"), sep=" "), file=outputfile, append =TRUE)
  ## write(paste(sprintf(mean(nor.count), fmt="%.3f"), sprintf(var(nor.count), fmt="%.3f"), sep=" "), file=outputfile, append =TRUE)
  ## write(paste(sprintf(mean(nor.count2), fmt="%#.4g"), sprintf(var(nor.count2), fmt="%#.4g"), sep=" "), file=outputfile, append =TRUE)
  ## write(" ", file=outputfile, append =TRUE)

}
  
countReads(r, x, n)



