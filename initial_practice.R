#upload file
montana_cropped<-readRDS(file.path("/Volumes/GoogleDrive/My Drive/USU/AdlerLabDocs/Spatiotemporal_practice/Data/cd_2.rds")) 
montana_cropped<-as.data.frame(montana_cropped)
montana_cropped$year<-1:30
head(montana_cropped)
dim(montana_cropped)

#
attach(montana_cropped) #so you don't have to do the dollar sign stuff....
?attach

#characterize spatial autocorrelation
#get a sense of the extent of spatial autocorrelation
Y<-log(npp) #transform to log scale so we aren't predicting negative values, more relevent to population dynamics
Y<-npp
#transform it back by using exponent (exp) function
log(0.1)

#create a design matrix
#first column as the intercept (B0), second column would be precip obs, yes, site, 
X<-cbind(1,mm.y)
head(X)
b<-solve(t(X)%*%X)%*%t(X)%*%Y #essentially the maximum likelihood estimate
#solve: inverse, t is transpose, 
b

#test
coef(lm(Y~X[,2]))#same thing a slm output

#
Ypred<-X%*%b
plot(Y,Ypred, cex=.01)
abline(0,1)

#if you want have this nonlinear, just add a quadratic term (or column) in your design matrix
#look at the residuals of this model to begin to assess autocorrelation

Yresid<-(Y-Ypred)
VarioData<-as.data.frame(cbind(Yresid[which(year==1)],x[which(year==1)],y[which(year==1)]))
colnames(VarioData)<-c('Yresid','lat','long')

library(gstat)
Vout<-variogram(Yresid~1,loc=~lat+long, data=VarioData, cutoff=2) ###this will take a few minutes
plot(Vout)
#semivariance as a unidirectional measure of variance

# introduction to stan
#programming language designed to to complex modeling
#have to declare what data structures look like before using them in stan

#in R
x<-1
y<-5
z<-x+y

#the parallel in stan
real x #declare as real so it can take on continuous values
real y
real z
x=1
y=5
z=x+y

#for a matrix, you'd have to declare its dimensions first