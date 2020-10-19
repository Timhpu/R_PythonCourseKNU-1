#setwd("C:\\Users\\User\\Documents")  # may need this
pmean <- function(directory, pollutant, id=1:332) {
  all_values <- c()
  for(filename in id)
  {
    filename <- toString(filename)
    filename <- paste(paste(rep(0, 3-nchar(filename)), collapse=""), filename, ".csv", sep="")
    df <- read.csv(file.path(directory, filename))
    all_values <- c(all_values, df[[pollutant]])
  }
  return(mean(all_values, na.rm=TRUE))
}

complete <- function(directory, id) {
  result <- data.frame("id", "nobs")
  for(fname in id)
  {
    filename <- toString(fname)
    filename <- paste(paste(rep(0, 3-nchar(filename)), collapse=""), filename, ".csv", sep="")
    df <- read.csv(file.path(directory, filename))
    result[nrow(result)+1, ] = list(fname, nrow(df[!is.na(df$sulfate)&!is.na(df$nitrate), ]))
  }
  return(result)
}

corr <- function(directory, threshold=0) {
  result = c()
  for(filename in 1:332)
  {
    filename <- toString(filename)
    filename <- paste(paste(rep(0, 3-nchar(filename)), collapse=""), filename, ".csv", sep="")
    df <- read.csv(file.path(directory, filename))
    ds <- df[!is.na(df$sulfate)&!is.na(df$nitrate), ]
    if (nrow(ds)>threshold)
    {
      result <- c(result, cor(ds$sulfate, ds$nitrate))
    }
  }
  return(result)
}