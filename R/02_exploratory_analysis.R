# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 2: Exploratory data analysis.

## Loading packages
library(dplyr)
library(tidyr)

## Loading the processed data
tricho_female <- read.csv("data/processed/tricho_female.csv")
tricho_processed <- read.csv("data/processed/tricho_processed.csv")

View(tricho_processed)
table(tricho_processed$spp) #abundance of each observed species

summary(tricho_processed)

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

## Calculating the corporeal condition (CC) of the female T. clavipes
# as the residuals from the regression between the log of their mass
# and the total size, and treating the CC as a representation of the females fitness.

# adding the log mass colum to thetricho female and tricho processed
tricho_female$log_mass <- log (tricho_female$mass_g, base = 10)
tricho_processed$log_mass <- log (tricho_processed$mass_g, base = 10)

# Subset - filtering that the log mass and the comprimento that doesnt have nas
tricho_female_cc <- tricho_female %>% filter(log_mass != "NA", total_length_mm != "NA")
nrow(tricho_female_cc)

CC_model  <- lm(log_mass ~ total_length_mm, tricho_female)
CC <-  as.vector(resid(CC_model))

tricho_female_cc$CC <- CC
class(tricho_female_cc$CC)
View(tricho_female_cc)


## Remembering our questions and plotting variables to observe their patterns

## 1. Interations between T. clavipes and the amount of argyrodes

# 1.1 Presence and absence of Argyrodes and the female
tricho_female_cc$pres_argy <- tricho_female_cc$n_argy
tricho_female_cc$pres_argy[tricho_female_cc$pres_argy==2]<-1
tricho_female_cc$pres_argy[tricho_female_cc$pres_argy==3]<-1
tricho_female_cc$pres_argy[tricho_female_cc$pres_argy==4]<-1
unique(tricho_female_cc$pres_argy)

tricho_female_cc$pres_argy <- factor(tricho_female_cc$pres_argy)

boxplot(tricho_female_cc$CC ~ tricho_female_cc$pres_argy)

# 1.2 CC Females and the number of Argyrodes
tricho_female_cc$n_argy <- as.numeric(tricho_female_cc$n_argy)
boxplot(tricho_female_cc$CC ~ tricho_female_cc$n_argy, ylab = "Female CC", xlab = "N Argyrodes")

# 1.3 Number Argyrodes and the presence of the "Food string"
class(tricho_female_cc$food_string)
tricho_female_cc$food_string <- factor(tricho_female_cc$food_string)
boxplot(tricho_female_cc$n_argy ~ tricho_female_cc$food_string, ylab = "N argyrodes", xlab = "food_string")

## 2. Males and females
# 2.1 CC female and male number
class(tricho_female_cc$n_males)
tricho_female_cc$n_males <- as.numeric(tricho_female_cc$n_males)
boxplot(CC ~ n_males, data = tricho_female_cc, ylab = "N argyrodes", xlab = "food_string")

# 2.2 CC females and presence of males
tricho_female_cc$males_presence <- tricho_female_cc$n_males
tricho_female_cc$males_presence[tricho_female_cc$males_presence==2]<-1
tricho_female_cc$males_presence[tricho_female_cc$males_presence==3]<-1
unique(tricho_female_cc$males_presence)
boxplot(CC ~ males_presence, data = tricho_female_cc, ylab = "CC Females", xlab = "Presence of males")

# 2.3 Food string mass and presence of males
boxplot(fs_mass ~ males_presence, data = tricho_female_cc)

# 2.4 Number of males and presence or absence of a string
boxplot(n_males ~ food_string, data = tricho_female_cc)

## 3. Number of Argyrodes and males
boxplot(n_argy ~ n_males, data = tricho_female_cc)

## 4. Agraggates

# 4.1 N Argyrodes agreggate
boxplot(n_argy ~ aggregate, data = tricho_female_cc)

# 4.2 N males agregate
boxplot(n_males ~ aggregate, data = tricho_female_cc)
