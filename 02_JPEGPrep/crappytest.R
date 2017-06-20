#some R script that can run
# test by charlene for github


timeseries = as.matrix(read.csv('../time_series.csv', header=TRUE));
d = 1:200;

par(mfrow=c(2,2));
plot(d,timeseries[1,], main="Model 1");
lines(d,timeseries[1,], main="Model 1");
plot(d,timeseries[6,], main="Model 2");
lines(d,timeseries[6,], main="Model 2");
plot(d,timeseries[4,], main="Model 3");
lines(d,timeseries[4,], main="Model 3");
plot(d,timeseries[5,], main="Model 4");
lines(d,timeseries[5,], main="Model 4");

# --------------------------------Code for Q4 Part B---------------------------------------
# Derive two features that effectively separate the time series into 4 categories when shown
# in a scatterplot. There may be many ways to do this. 

timeseries = as.matrix(read.csv('../time_series.csv', header=TRUE));
d = 1:200;
find_peaks <- function (x, thresh = 10) 
{
  pks <- which(diff(sign(diff(x, na.pad = FALSE)), na.pad = FALSE) < 0) + 2
  if (!missing(thresh)) {
    pks[x[pks - 1] - x[pks] > thresh]
  }
  else pks
}

peaks <- apply(timeseries, 1, find_peaks);
numPeaks <- lengths(peaks);

numCrosses <- rep(0, length=200);
for (i in 1:200) {
  numCrosses[i] <- sum(diff(sign(timeseries[i,])) != 0);
}

plot(numCrosses, numPeaks);
