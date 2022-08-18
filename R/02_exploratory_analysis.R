# Scientific programming course ICTP-Serrapilheira August-2022
# Project: Polyandry in Trichonephila clavipes
# Script 2: Exploratory data analysis.

## Loading packages

## Loading the processed data
tricho_female <- read.csv("data/processed/tricho_female.csv")
tricho_processed <- read.csv("data/processed/tricho_processed.csv")

View(tricho_processed)
table(tricho_processed$spp) #abundance of each observed species

summary(tricho_processed)

## Visualizing the frequency of our numerical parameters
par(mfrow = c(4, 2))
hist(tricho_female$massa_g)
hist(tricho_female$N_Argyrodes)
hist(tricho_female$N_machos)
hist(tricho_female$Altura_teia_m)
hist(tricho_female$comprimento_total_mm)
hist(tricho_female$largura_cefalot_mm)
hist(tricho_female$massa_colar_g)
hist(tricho_female$N_femeas_total_agregado)

class(tricho_female$massa_g)
tricho_female$N_Argyrodes <- as.numeric(tricho_female$N_Argyrodes)
class(tricho_female$N_Argyrodes)

plot(tricho_female$N_machos ~ tricho_female$N_Argyrodes)



?boxplot
