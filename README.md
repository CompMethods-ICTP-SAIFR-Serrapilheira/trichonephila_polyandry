# Trichonephila clavipes females and their web tenants

## Theoretical Background

The polyandrous mating system (multiple males for one female), is common in several spider species. In the case of spiders of the species Trichonephila clavipes, known as golden web spiders, copulation with several males may be especially advantageous since the copula with more than one male leads to an offspring with more genetic diversity. Presenting strong size sexual dimorphism, with females way larger than males, in this species, is not uncommon to find a large web (always made by females) with multiple males wainting for the chance to mate. However, the males of T. clavipes are not the only spiders that resids in the female's web. It's not uncommon to find other species in their webs, kleptoparasitic species such as the Argyrodes, that eats the prey stuck in T. clavipes web (Silveira et al., 2012). One interesting behavior that can be seen in the females of T.clavipes is the production of a food string, a string made of web and parts of the remaing animals that have been eaten by it. Those strings are easily observable in ther webs, and varies in size and shape. Moreover, the females of T. clavipes can combine webs with other females and form aggregates.

## Goals 
  
Given that males exhibit preferences for larger females in other spider taxa (Andersson, 1994), due to their body condition being related to their ability to carry eggs, and given what was discussed before. Our goal is to understand what parameters determine the amount of males  spiders are present in a single web. Consecutively, my hypothesis are that:
(1) The amount of males in a single web is related to the body conditions of the female. 
(2) The presence of Argyrodes repels males of T. clavipes and vice-versa.


## Dataset

Data collected in December 2020 in a field course in the environmental reseve: "Fazenda Água Limpa", Brasília - DF by Izabel Salvi, Felipe Malheiros, Paulo César Motta, Felipe Brasil, Luiza Cintra e Fernanda Marinho. 


## Analysis 

To check the possible relations, it was applied a generalized linear model to understand the parameters that explain the variation of the number of males of T. clavipes in each web.

## Data set variables
"collectors" = Name of the collectors
"ID_individual" = ID of a single individual
"ID_web" = ID of the web
"ID_aggregate" =  ID of the aggregate
"time" = time f collection
"local" = local of the sampling
"spp" = Species
"sex" = sex of the individual
"age" =  if young (J), or adult (A)
"web_heigth" = distance from the floor to the middle of the web 
"n_argy" = number of Argyrodes in a web
"n_males" = number of males in a web
"mass_g" = mass of the female T. clavipes in grams
"total_length_mm" = total length of the female T. clavipes in mm
"cephalot_width_mm" = width of the cephalotorax of the female T. clavipes in mm
"food_string" = if there was a food string in the web
"fs_mass" = mass of the food string 
"aggregate" = if the spider was in a single web or an aggregate
"n_fem_aggregate" = number of females present in the aggregate
"if_feeding" = if the síder was eating when collected
                           
                           
# Requirements 
> R packages used
  - tidyr
  - dplyr
  - PerformanceAnalytics
  - bbmle
  - PerformanceAnalytics
  - MuMIn
  - DHARMa
  - psych
  - regclass


```
project/
*    ├── data/
*    │   ├── raw
*    │   └── processed
     ├── docs/
*    ├── figs/
     ├── R/
*    └── README.md
```

