# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 1: reading raw data, creating processed data and tidying the data.

## Loading packages
library(tidyr)


# Reading the data

tricho_data <- read.csv("data/raw/tricho_data.csv", sep = ';', na.strings=c("","NA"))


# Exploring the data
View(tricho_data)
head(tricho_data)
dim(tricho_data)
summary(tricho_data)
names(tricho_data)

# Removing the 'observações' and 'se.alimentando' column
tricho_data <- subset(tricho_data, select = -c(observacoes, se_alimentando))
names(tricho_data)

# Checking to see if the names of the species in the spp clumns are correct
unique(tricho_data$spp)
#we can see that there are three different notations for the same species: Argyrodes elevatus

tricho_data["spp"][tricho_data["spp"] == "        Argyrodes elevatus" |
                     tricho_data["spp"] == "       Argyrodes elevatus"] <- "Argyrodes elevatus"

# Checking all future factor columns to see if the notation is correct, and changing
# their names if necessary
unique(tricho_data$se_alimentando.1)

unique(tricho_data$Local)
tricho_data["Local"][tricho_data["Local"] == "Regiao Lagoa" |
                       tricho_data["Local"] == "Regi\xe3o Lagoa" |
                       tricho_data["Local"] == "Regiao Lagoa\n"   ] <- "regiao lagoa"
tricho_data["Local"][tricho_data["Local"] == "Port\xe3o Amarelo"] <- "portao amarelo"


unique(tricho_data$tipo)

unique(tricho_data$Sexo)
tricho_data["Sexo"][tricho_data["Sexo"] == "Macho " |
                      tricho_data["Sexo"] ==  "Macho" |
                      tricho_data["Sexo"] == "Macho\n"] <- "macho"
richo_data["Sexo"][tricho_data["Sexo"] == "Femea\n" |
                     tricho_data["Sexo"] == "Femea"] <- "femea"

unique(tricho_data$agregado)

unique(tricho_data$colar)

# For posterior analysis, it is important to have some columns parameters defined as factors
class(tricho_data$spp)

tricho_data$spp <- factor(tricho_data$spp)
tricho_data$Local <- factor(tricho_data$Local)
tricho_data$tipo <- factor(tricho_data$tipo)
tricho_data$Sexo <- factor(tricho_data$Sexo)
tricho_data$Idade <- factor(tricho_data$Idade)
tricho_data$colar <- factor(tricho_data$colar)
tricho_data$agregado <- factor(tricho_data$agregado)
tricho_data$se_alimentando.1 <- factor (tricho_data$se_alimentando.1)

# FOr posterior analisys (describe here what are the analisys), it would be easier to have a
# with only the females
?dplyr::filter()

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




