# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 1: reading raw data, creating processed data and tidying the data.

## Loading packages
library(tidyr)
library(dplyr)


# Reading the data

tricho_data <- read.csv("data/raw/tricho_data.csv", sep = ';', na.strings=c("","NA", "N/A"))


# Exploring the data
View(tricho_data)
head(tricho_data)
dim(tricho_data)
summary(tricho_data)
names(tricho_data)

# Removing the 'observações' and 'se.alimentando' column
tricho_data <- subset(tricho_data, select = -c(observacoes, se_alimentando, Tamanho_teia))
names(tricho_data)

# Changing the names of the columns
names(tricho_data)
colnames(tricho_data) <- c("collectors","ID_individual","ID_web", "ID_aggregate", "time", "local",
                           "experiment", "spp", "type", "sex", "age", "web_heigth", "n_argy", "n_males",
                           "mass_g", "total_length_mm", "cephalot_width_mm", "food_string", "fs_mass",
                           "aggregate", "n_fem_aggregate", "if_feeding" )
View(tricho_data)

# Checking to see if the names of the species in the spp clumns are correct
unique(tricho_data$spp)
#we can see that there are three different notations for the same species: Argyrodes elevatus

tricho_data["spp"][tricho_data["spp"] == "        Argyrodes elevatus" |
                     tricho_data["spp"] == "       Argyrodes elevatus"] <- "Argyrodes elevatus"

# Checking all future factor columns to see if the notation is correct, and changing
# their names if necessary
unique(tricho_data$if_feeding)
tricho_data["if_feeding"][tricho_data["if_feeding"] == "nao"] <- "no"
tricho_data["if_feeding"][tricho_data["if_feeding"] == "sim"] <- "yes"


unique(tricho_data$local)
tricho_data["local"][tricho_data["local"] == "Regiao Lagoa" |
                       tricho_data["local"] == "Regi\xe3o Lagoa" |
                       tricho_data["local"] == "Regiao Lagoa\n"   ] <- "regiao lagoa"
tricho_data["local"][tricho_data["local"] == "Port\xe3o Amarelo"] <- "portao amarelo"


unique(tricho_data$type)
tricho_data["type"][tricho_data["type"] == "femea"] <- "female"
tricho_data["type"][tricho_data["type"] == "inquilino"] <- "tennant"



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


# For posterior analysis, it will be important to have a table with the females T. clavipes
tricho_female <-  tricho_data %>% filter(tricho_data$spp == "Trichonephila clavipes")



# creating a new data set with all the modifications and exporting it
tricho_processed <-  tricho_data

if (!dir.exists("data/processed")) dir.create("data/processed")

write.csv(x = tricho_processed,
          file = "data/processed/tricho_processed.csv",
          row.names = TRUE)

write.csv(x = tricho_female,
          file = "data/processed/tricho_female.csv",
          row.names = TRUE)




