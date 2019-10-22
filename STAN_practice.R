library(rstan)

#for a matrix, you'd have to declare its dimensions first
Y=rnorm(X[1:100,]%*%b,1)
Y

modelcode="

data{
  matrix[100,2] X;//set up matrix, 100 rows, ten columsn corresponding to model
  vector[100] Y;  //what you are trying to predict
}

parameters{
  vector[2] b;
  real<lower=0> sigma; 
}

transformedparameters{
  vector[100] mu;
  mu=X*b; //mean term
}

//stan defaults to do doing matrix alegbra, unlike R, where you have to do the % stuff

model{
  
  Y~normal(mu,sigma); //sigma as variance
}

"
dat=list("X"=X[1:100,],"Y"=Y)
fit=stan(model_code=modelcode,data=dat,chains=1)