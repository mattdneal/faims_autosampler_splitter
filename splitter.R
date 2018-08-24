formnum <- function(num) {
  return(paste(c(rep(0, 4-nchar(num)), num), collapse=""))
}

splitter <- function(dir, extension="asc") {
  cat("Matt's Magical FAIMS Splitter, Xmas Edition. v1.0")
  sample.names <- scan(file.path(dir,"sampleNames.txt"), what="", sep="\n")
  cat("Sample names found: ", fill=T) 
  for (i in sample.names) {
    cat(" - ", i, fill=T)
  }
  
  nfiles <- length(list.files(dir, pattern = paste(".*[0-9]+[.]", extension, sep="")))
  cat(nfiles, "FAIMS files found.", fill=T)
  
  max.flow <- numeric(nfiles)
  min.flow <- numeric(nfiles)
  sample.id <- numeric(nfiles)
  max.id <- 0
  
  for (i in 1:nfiles) {
    num <- formnum(i)
    file <- list.files(dir, pattern = paste(".*", num, "[.]", extension, sep=""))
    if (length(file) != 1) stop(paste("Error with run", num))
    data = scan(file.path(dir, file), skip=63, nlines=51, quiet=T, what=character())
    data = matrix(data, 51, byrow=T)
    flow = as.numeric(data[, 15])
    max.flow[i] <- max(flow)
    min.flow[i] <- min(flow)
    if (min.flow[i] < 1.9) {
      sample.id[i] <- -1
    } else {
      if (i == 1) {
        max.id <- max.id + 1
        sample.id[i] <- max.id
      } else if (sample.id[i - 1] == -1) {
        max.id <- max.id + 1
        sample.id[i] <- max.id
      } else {
        sample.id[i] <- sample.id[i - 1]
      }
    }
  }
  col <- sample(rainbow(max.id+2), max.id+2)[sample.id + 2]
  col[sample.id==-1] <- 1
  png("Sample_ID_against_run_number.png")
  plot(sample.id, main="Sample ID against run number. -1 == between runs", col=col)
  dev.off()
  png("Min_flow_rate.png")
  plot(min.flow, main="Minimum flow rate per run. <1.9 == between runs", col=col)
  dev.off()
  if (length(sample.names) != max.id) stop("Number of samples does not match number of sample names. See plots to debug. Identify failed sample and remove from sampleNames.txt")
  dir.create(file.path(dir, "Between"))
  
  cat("Copying in-between runs", fill=T)
  for (i in which(sample.id == -1)) {
    num <- formnum(i)
    file <- list.files(dir, pattern = paste(".*", num, "[.]", extension, sep=""))
    file.copy(file.path(dir, file), file.path(dir, "Between"), overwrite = T, recursive = F)
  }
  for (id in 1:max.id) {
    cat("Copying sample", sample.names[id], fill=T)
    dir.create(file.path(dir, sample.names[id]))
    for (i in which(sample.id == id)) {
      num <- formnum(i)
      file <- list.files(dir, pattern = paste(".*", num, "[.]", extension, sep=""))
      file.copy(file.path(dir, file), file.path(dir, as.character(sample.names[id])), overwrite = T, recursive = F)
    }
  }
  cat("Complete!", fill=T)
}

args <- commandArgs(TRUE)
splitter(args[1], args[2])