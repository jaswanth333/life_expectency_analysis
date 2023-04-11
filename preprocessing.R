rm(list=ls())

library(tidyverse)

df <- read.csv(file = "Life_Expectancy_Data.csv")
unique(df$Year)
names(df)
fiveyears <- df %>% filter(df$Year >"2010" & df$Year<= "2015")
colSums(is.na(fiveyears)) #Missing Values
df <- df[-c(3,18)]

df2010 <- df %>% filter(df$Year == "2010")


Pop <- read.csv("countries_population_data.csv")
Pop <- Pop[c(1, 55)]
names(Pop)[1] <- "Country"
names(Pop)[2] <- "Population"

test <- left_join(fiveyears, Pop, by="Country")
colSums(is.na(test)) #Missing Values
test <- test %>% filter(is.na(test$fiveyears))
test <- unique(test[c("Country")])

df2010$Country[df2010$Country == "Côte d'Ivoire"] <- "Cote d'Ivoire"
df2010$Country[df2010$Country == "Bolivia (Plurinational State of)"] <- "Bolivia"
df2010$Country[df2010$Country == "Czechia"] <- "Czech Republic"
df2010$Country[df2010$Country == "Lao People's Democratic Republic"] <- "Lao PDR"
df2010$Country[df2010$Country == "Saint Lucia"] <- "St. Lucia"
df2010$Country[df2010$Country == "Saint Vincent and the Grenadines"] <- "St. Vincent and the Grenadines"
df2010$Country[df2010$Country == "The former Yugoslav republic of Macedonia"] <- "North Macedonia"
df2010$Country[df2010$Country == "United Kingdom of Great Britain and Northern Ireland"] <- "United Kingdom"
df2010$Country[df2010$Country == "United Republic of Tanzania"] <- "Tanzania"
df2010$Country[df2010$Country == "Viet Nam"] <- "Vietnam"
Pop$Country[Pop$Country == "Bahamas, The"] <- "Bahamas"
Pop$Country[Pop$Country == "Congo, Dem. Rep."] <- "Democratic Republic of the Congo"
Pop$Country[Pop$Country == "Congo, Rep."] <- "Congo"
Pop$Country[Pop$Country == "Korea, Dem. People's Rep."] <- "Democratic People's Republic of Korea"
Pop$Country[Pop$Country == "Egypt, Arab Rep."] <- "Egypt"
Pop$Country[Pop$Country == "Gambia, The"] <- "Gambia"
Pop$Country[Pop$Country == "Iran, Islamic Rep."] <- "Iran (Islamic Republic of)"
Pop$Country[Pop$Country == "Kyrgyz Republic"] <- "Kyrgyzstan"
Pop$Country[Pop$Country == "Micronesia, Fed. Sts."] <- "Micronesia (Federated States of)"
Pop$Country[Pop$Country == "Korea, Rep."] <- "Republic of Korea"
Pop$Country[Pop$Country == "Moldova"] <- "Republic of Moldova"
Pop$Country[Pop$Country == "Slovak Republic"] <- "Slovakia"
Pop$Country[Pop$Country == "Eswatini"] <- "Swaziland"
Pop$Country[Pop$Country == "United States"] <- "United States of America"
Pop$Country[Pop$Country == "Venezuela, RB"] <- "Venezuela (Bolivarian Republic of)"
Pop$Country[Pop$Country == "Yemen, Rep."] <- "Yemen"


df2010 <- left_join(df2010, Pop, by="Country")


