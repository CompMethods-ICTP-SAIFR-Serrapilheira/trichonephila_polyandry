# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 2: Exploratory data analysis.

## In this script, I analyse the structure of our data, and chack for possible patterns and correlations

## Loading packages
#install.packages("PerformanceAnalytics")
#install.packages("dplyr")
#install.packages("tidyr")
library(dplyr)
library(tidyr)
library(PerformanceAnalytics)

## Loading the processed data
tricho_female <- read.csv("data/processed/tricho_female.csv")
tricho_processed <- read.csv("data/processed/tricho_processed.csv")


table(tricho_processed$spp) #abundance of each observed species
summary(tricho_processed)
head(tricho_female)

## Visualizing the frequency of our numerical parameters
par(mfrow = c(4, 2))
hist(tricho_female$mass_g)
hist(tricho_female$n_argy)
hist(tricho_female$n_males)
hist(tricho_female$web_heigth)
hist(tricho_female$total_length_mm)
hist(tricho_female$cephalot_width_mm)
hist(tricho_female$fs_mass)
hist(tricho_female$n_fem_aggregate)

names(tricho_female)

## Checking to see if there are any possible correlations between numerical variables

# Creating a subset of tricho female with only the numerical data needed
tricho_female_num <- data.frame(tricho_female$ID_individual, tricho_female$sex, tricho_female$age, tricho_female$web_heigth, tricho_female$n_argy,
                                tricho_female$n_males, tricho_female$total_length_mm,
                                tricho_female$cephalot_width_mm, tricho_female$fs_mass, tricho_female$n_fem_aggregate,
                                tricho_female$log_mass, tricho_female$BC)

head(tricho_female_num)
quantit_corr <- chart.Correlation(tricho_female_num[,c(4,5,6,7,8,9,10,11,12)], histogram=TRUE, pch=19)
png(file="figs/quantit_corr.png", width = 2000, height = 2000)
print(chart.Correlation(tricho_female_num[,c(4,5,6,7,8,9,10,11,12)], histogram=TRUE, pch=19))
dev.off() # exporting the figure

## We can see that it doesn't seen to have any clear meaningful correlations. Therefore, we will
# check some qualitative variables utilizing boxplots.


## Remembering our questions and plotting variables to check for their relations

## 1. Interations between T. clavipes and the amount of argyrodes

# 1.1 Presence and absence of Argyrodes and the female BC
par(mfrow = c(1,1))
unique(tricho_female$pres_argy)
boxplot(tricho_female$BC ~ tricho_female$pres_argy)

# 1.2 BC Females and the number of Argyrodes
tricho_female$n_argy <- as.numeric(tricho_female$n_argy)
boxplot(tricho_female$BC ~ tricho_female$n_argy, ylab = "Female BC", xlab = "N Argyrodes")

# 1.3 Number Argyrodes and the presence of the "Food string"
class(tricho_female$food_string)
tricho_female$food_string <- factor(tricho_female$food_string)
boxplot(tricho_female$n_argy ~ tricho_female$food_string, ylab = "N argyrodes", xlab = "food_string")

## 2. Males and females
# 2.1 BC female and male number
class(tricho_female$n_males)
tricho_female$n_males <- as.numeric(tricho_female$n_males)
boxplot(BC ~ n_males, data = tricho_female, ylab = "BC Female", xlab = "N males")

# 2.2 BC females and presence of males
unique(tricho_female$males_presence)
boxplot(BC ~ males_presence, data = tricho_female, ylab = "BC Females", xlab = "Presence of males")


# 2.3 Food string mass and presence of males
boxplot(fs_mass ~ males_presence, data = tricho_female)

# 2.4 Number of males and presence or absence of a string
boxplot(n_males ~ food_string, data = tricho_female)



## 3. Aggregates

# 3.1 Number of Argyrodes and agreggates
boxplot(n_argy ~ aggregate, data = tricho_female)

# 3.2 Number of males and agregates
boxplot(n_males ~ aggregate, data = tricho_female,
        xlab = "Aggregate", ylab = "Number of males/web")
png(file="figs/box_maleaggregate.png", width = 500, height = 500)
print(boxplot(n_males ~ aggregate, data = tricho_female,
              xlab = "Aggregate", ylab = "Number of males/web"))
dev.off()


## 4. Males and Argyrodes

# 4.1 Number of males and presence of Argyrodes
boxplot(n_males ~ pres_argy , data = tricho_female,
        xlab = "Presence of Argyrodes", ylab = "Number of males")
png(file="figs/box_maleargy.png", width = 500, height = 500)
print(boxplot(n_males ~ pres_argy , data = tricho_female,
              xlab = "Presence of Argyrodes", ylab = "Number of males"))
dev.off()

# 4.2 Number of Argyrodes and presence of males
boxplot(n_argy ~ males_presence, data = tricho_female)


## Exporting the new table
write.csv(x = tricho_female,
          file = "data/processed/tricho_female.csv",
          row.names = TRUE)
head(tricho_female)

