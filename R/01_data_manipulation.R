# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 1: reading raw data, creating processed data and tidying the data.

## This script is for cleaning the raw data, adding needed columns for future analysis and
# exporting processed datasets.

## Loading packages
library(tidyr)
library(dplyr)


## Reading the data

tricho_data <- read.csv("data/raw/tricho_data.csv", sep = ';', na.strings=c("","NA", "N/A"))


## Exploring the data
View(tricho_data)
head(tricho_data)
dim(tricho_data)
summary(tricho_data)
names(tricho_data)

## Removing the 'observações', 'se.alimentando', 'tipo', 'experimento' and 'tamanho teia' columns.
# For our analysis, those columns won't be important.
tricho_data <- subset(tricho_data, select = -c(observacoes, se_alimentando, Tamanho_teia, Experimento, tipo, se_alimentando.1))
names(tricho_data)

## Changing the names of the columns
names(tricho_data)
colnames(tricho_data) <- c("collectors","ID_individual","ID_web", "ID_aggregate", "time", "local",
                            "spp", "sex", "age", "web_heigth", "n_argy", "n_males",
                           "mass_g", "total_length_mm", "cephalot_width_mm", "food_string", "fs_mass",
                           "aggregate", "n_fem_aggregate")
head(tricho_data)

## Checking to see if the names of the species in the spp column are correct
unique(tricho_data$spp)

# we can see that there are three different notations for the same species: Argyrodes elevatus
tricho_data["spp"][tricho_data["spp"] == "        Argyrodes elevatus" |
                     tricho_data["spp"] == "       Argyrodes elevatus"] <- "Argyrodes elevatus"

## Checking all future factor columns to see if the notation is correct, and changing
# their names if necessary
unique(tricho_data$local)
tricho_data["local"][tricho_data["local"] == "Regiao Lagoa" |
                       tricho_data["local"] == "Regi\xe3o Lagoa" |
                       tricho_data["local"] == "Regiao Lagoa\n"   ] <- "regiao lagoa"
tricho_data["local"][tricho_data["local"] == "Port\xe3o Amarelo"] <- "portao amarelo"


unique(tricho_data$sex)
tricho_data["sex"][tricho_data["sex"] == "Macho " |
                      tricho_data["sex"] ==  "Macho" |
                      tricho_data["sex"] ==  "macho" |
                      tricho_data["sex"] == "Macho\n"] <- "male"
tricho_data["sex"][tricho_data["sex"] == "Femea\n" |
                      tricho_data["sex"] == "femea" |
                     tricho_data["sex"] == "Femea"] <- "female"

unique(tricho_data$aggregate)
tricho_data["aggregate"][tricho_data["aggregate"] == "nao"] <- "no"
tricho_data["aggregate"][tricho_data["aggregate"] == "sim"] <- "yes"


unique(tricho_data$food_string)
tricho_data["food_string"][tricho_data["food_string"] == "com"] <- "present"
tricho_data["food_string"][tricho_data["food_string"] == "sem"] <- "absent"

unique(tricho_data$age)
tricho_data["age"][tricho_data["age"] == "MA"] <- "A" #previously it was ma as in male adult, now we are changing for just adult
tricho_data["age"][tricho_data["age"] == "SA"] <- "A"
tricho_data["age"][tricho_data["age"] == "MJ"] <- "J"

## One of the objectives of this analysis is to see the relations between number of T. clavipes
# males and the body condition (BC), treating it as a representation of their fitness. Given that, a
# column for body condition will be added to the df, and the BC will be calculated as the residuals
# from the regression between the log of their mass and the total size

# Adding the log mass colum to the tricho data
tricho_data$log_mass <- log (tricho_data$mass_g, base = 10)

# Subset - filtering that the log mass and the comprimento that doesnt have nas
tricho_bc <- tricho_data %>% filter(log_mass != "NA", total_length_mm != "NA")
nrow(tricho_bc)

BC_model  <- lm(log_mass ~ total_length_mm, tricho_bc)
BC <-  as.vector(resid(BC_model))

tricho_bc$BC <- BC
head(tricho_bc)
class(tricho_bc$BC)

## It will be important as well, to have qualitative colums of the presence and absence
# of T. clavipes males and Argyrodes to check if one affects the other

# Argyrodes
tricho_bc$pres_argy <- tricho_bc$n_argy
tricho_bc$pres_argy[tricho_bc$pres_argy==2]<-1
tricho_bc$pres_argy[tricho_bc$pres_argy==3]<-1
tricho_bc$pres_argy[tricho_bc$pres_argy==4]<-1
unique(tricho_bc$pres_argy)
tricho_bc$pres_argy <- factor(tricho_bc$pres_argy)

# T. clavipes males
tricho_bc$males_presence <- tricho_bc$n_males
tricho_bc$males_presence[tricho_bc$males_presence==2]<-1
tricho_bc$males_presence[tricho_bc$males_presence==3]<-1

## For posterior analysis, it will be important to have a table with only in the females
# of T. clavipes in the spp colum
tricho_female <-  tricho_bc %>% filter(tricho_bc$spp == "Trichonephila clavipes")

# creating a new data set with all the modifications and exporting it
tricho_processed <-  tricho_bc

if (!dir.exists("data/processed")) dir.create("data/processed")

write.csv(x = tricho_processed,
          file = "data/processed/tricho_processed.csv",
          row.names = TRUE)

write.csv(x = tricho_female,
          file = "data/processed/tricho_female.csv",
          row.names = TRUE)




