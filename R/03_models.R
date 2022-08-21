# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 3: LM

## In this script we will use generalized linear models to analyse the relationships between
# the number of males in a web with the Trichonephila clavipes females parameters, as well as the
# spacial parameters (such as the presence of a food string, and if the web part of an aggregate).


## Install packages
#install.packages("packages/modelvalidation_0.4.0.tar.gz", repos = NULL, type = "source")
#install.packages("MuMIn")
#install.packages("bbmle")
#install.packages("DHARMa") #qq
#install.packages("psych") #multicolinearity
#install.packages("regclass") #vif
library(bbmle)
library(modelvalidation)
library(PerformanceAnalytics)
library(MuMIn)
library(DHARMa)
library(psych)
library(regclass)

## Reading the data
tricho_female <- read.csv("data/processed/tricho_female.csv")


## In our table we have for most parameters variables with both qualitative data (presence or absence),
# and quantitative data (abundance) for multiple variables. Assuming that our response variables
# is the number of T. clavipes males may be explained by both only the  qualitative and quantitative
# parameters (i.e if there is a single food string in the orb, or the mass of the food string),
# and taking into consideration the plots observed in the second script, we wil do one analysis using mostly
# qualitative variables.


### Quantitative model using the number of males as our response variable:

# Since our response variable is discrete with most values in the left part of
# the graph, I'm chosing the Poisson GLM
hist(tricho_female$n_males)

dataglm_nmales <- data.frame(tricho_female$n_males, tricho_female$pres_argy, tricho_female$food_string,
               tricho_female$aggregate, tricho_female$BC)

head(tricho_female)

tcglm <- glm(n_males ~  pres_argy + food_string + aggregate + BC,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm2 <- glm(n_males ~  food_string + aggregate + BC,
              family = poisson(link="log"), data = tricho_female,
              na.action = "na.omit" )
tcglm3 <- glm(n_males ~   pres_argy + aggregate + BC,
              family = poisson(link="log"), data = tricho_female,
              na.action = "na.omit" )
tcglm4 <- glm(n_males ~  pres_argy + food_string  + BC,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm5 <- glm(n_males ~  pres_argy + food_string + aggregate,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm6 <- glm(n_males ~  pres_argy + food_string,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm7 <- glm(n_males ~  pres_argy + aggregate,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm8 <- glm(n_males ~  pres_argy + BC,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm9 <- glm(n_males ~  food_string + aggregate,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm10 <- glm(n_males ~   food_string + BC,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm11 <- glm(n_males ~ aggregate + BC,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm12 <- glm(n_males ~  pres_argy ,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm13 <- glm(n_males ~  food_string ,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm14 <- glm(n_males ~  aggregate ,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm15 <- glm(n_males ~  BC,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )
tcglm16 <- glm(n_males ~  1,
             family = poisson(link="log"), data = tricho_female,
             na.action = "na.omit" )

AICtab (tcglm, tcglm2 , tcglm3, tcglm4, tcglm5, tcglm6, tcglm7, tcglm8,
        tcglm9, tcglm10, tcglm11, tcglm12, tcglm13, tcglm14, tcglm15, tcglm16,
        base = TRUE, weights = TRUE)

## I cannot discard the dAIC smaller than 2, but we should take in considerations the two models
# with the smallest AIC: tcglm3 and tcglm11. The secong one has a higher delta than the first, but
# it has less parameters.

## Validating the model (checking if the chosed method fits the assumptions)
par(mfrow = c(2, 2))
plot(tcglm11)

par(mfrow = c(2, 2))
plot(tcglm3)



## 1. Dispersion and deviation tests
simulateResiduals(tcglm3, plot = T)
simulateResiduals(tcglm11 , plot = T)


## 2. Overdispersion parameter (should be close to 1)
sum(resid(tcglm3, type = "pearson")^2)/(tcglm3$df.residual) #close to one
sum(resid(tcglm11, type = "pearson")^2)/(tcglm3$df.residual)


## 3. Multicolinearity (<0.80) and VIF (<3, up to 10) between independent variables;
pairs.panels(dataglm_nmales)
VIF(tcglm3)
VIF(tcglm11)

## the models fit the asumptions

#Analysing the models
summary(tcglm3)
par(mfrow = c(2,2))
boxplot(n_males ~ pres_argy, data = tricho_female)
boxplot(n_males ~ aggregate , data = tricho_female)
plot(n_males ~ BC , data = tricho_female)
  # Looking at the Coefficients, we can see a ternd of the number of males diminushing if it is
# in an aggragate, and increasing if Argyrodes are present, and increasing even more with the body
# condition of the females.

summary(tcglm11)
par(mfrow = c(1,2))
plot(n_males ~ BC, data = tricho_female)
boxplot(n_males ~ aggregate , data = tricho_female)
  # We can see the same trends in this models, the difference is that in this model we dont
# have presence f argyrodes as a predictive variable.
