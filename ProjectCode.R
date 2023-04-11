library(tidyverse)
library(psych)
library(ggcorrplot)
library(plotly)
library(leaps)
library(caret)
library(countrycode)
df <- read.csv(file = "Life_Expectancy_Data_cleaned.csv")
summary(df)
df<-na.omit(df)

#Avg life expect
df %>% group_by(Status) %>%  summarise_at(vars(Life.expectancy), list(Life.expectancy = mean)) %>%
  ggplot(aes(x=Status,y=Life.expectancy))+
  geom_bar(aes(fill=Status),stat='identity')+labs(title="Average Life Expectancy of countries (2000-2015)",
                                                  y="Life Expectancy")


df %>%group_by(Country) %>%  
  summarise_at(vars(Life.expectancy), list(Life.expectancy = mean)) %>% 
  filter(rank((Life.expectancy))<=10) %>%
  mutate(Country = fct_reorder(Country, Life.expectancy)) %>%
  ggplot(aes(x=Country,y=Life.expectancy))+
  geom_bar(aes(fill=Country),stat='identity')+labs(title="Top 10 countries with Lowest Life expectancy")

fig<-df %>% group_by(Year,Status) %>%  
  summarise_at(vars(Life.expectancy),list(Life.expectancy = mean)) %>%
  ggplot(aes(x=Year, y=Life.expectancy, group=Status,color=Status)) + 
  labs(x="Year",
       y="Life Expectancy(Avg)",
       title = "Average Life Expectancy (2010-2015)")+
  geom_line()+geom_smooth(method=lm)+theme(axis.text.y = element_text(angle = 90, vjust = 0.5, hjust=1))

ggplotly(fig)

df <- df %>% filter(df$Year >="2010" & df$Year<= "2015")
colSums(is.na(df)) #Missing Values
df$Population.y<-as.numeric(df$Population.y)
df$infant.deaths<-as.numeric(df$infant.deaths)
summary(df)


df<-df %>% group_by(Year) %>%  mutate(BMI = ifelse(is.na(BMI), median(BMI, na.rm = TRUE), 
                                              BMI))
df<-df %>% group_by(Year) %>%  mutate(thinness..1.19.years = ifelse(is.na(thinness..1.19.years), median(thinness..1.19.years, na.rm = TRUE), 
                                                                    thinness..1.19.years))

df<-df %>% group_by(Year) %>%  mutate(Income.composition.of.resources = ifelse(is.na(Income.composition.of.resources), median(Income.composition.of.resources, na.rm = TRUE), 
                                                                    Income.composition.of.resources))
df<-df %>% group_by(Year) %>%  mutate(thinness.5.9.years = ifelse(is.na(thinness.5.9.years), median(thinness.5.9.years, na.rm = TRUE), 
                                                                               thinness.5.9.years))
df<-df %>% group_by(Year) %>%  mutate(Schooling = ifelse(is.na(Schooling), median(Schooling, na.rm = TRUE), 
                                                                               Schooling))
df<-df %>% group_by(Year) %>%  mutate(GDP = ifelse(is.na(GDP), median(GDP, na.rm = TRUE), 
                                                   GDP))
df<-df %>% group_by(Year) %>%  mutate(Diphtheria = ifelse(is.na(Diphtheria), median(Diphtheria, na.rm = TRUE), 
                                                          Diphtheria))
df<-df %>% group_by(Year) %>%  mutate(Polio = ifelse(is.na(Polio), median(Polio, na.rm = TRUE), 
                                                     Polio))
df<-df %>% group_by(Year) %>%  mutate(Total.expenditure = ifelse(is.na(Total.expenditure), median(Total.expenditure, na.rm = TRUE), 
                                                                 Total.expenditure))
df<-df %>% group_by(Year) %>%  mutate(Alcohol = ifelse(is.na(Alcohol), median(Alcohol, na.rm = TRUE), 
                                                       Alcohol))
df<-df %>% group_by(Year) %>%  mutate(Adult.Mortality = ifelse(is.na(Adult.Mortality), median(Adult.Mortality, na.rm = TRUE), 
                                                               Adult.Mortality))
df<-df %>% group_by(Year) %>%  mutate(Life.expectancy = ifelse(is.na(Life.expectancy), median(Life.expectancy, na.rm = TRUE), 
                                                               Life.expectancy))
df<-df %>% group_by(Year) %>%  mutate(Hepatitis.B = ifelse(is.na(Hepatitis.B), median(Hepatitis.B, na.rm = TRUE), 
                                                           Hepatitis.B))
df$Country[df$Country == "United Kingdom of Great Britain and Northern Ireland"] <- "United Kingdom"
vector2<-which(is.na(df$Population.y))
new_DF <- df[rowSums(is.na(df)) > 0,]
vector1 <- c(17833,3342818, 3311449,3281499,3250100,3213972,1612,109135,108868,108624,108435,108315)

for (i in 1:nrow(new_DF)){
  df$Population.y[vector2[i]]<-vector1[i]
}

write.csv(df,"finaldata2.csv",row.names = FALSE)
summary(df)
main_data=subset(df, select=-c(Country,Status))
boxrep = par(mfrow = c(4,5))
for ( i in 1:19 ) {
  
  boxplot(as.numeric(main_data[[i]]),col='lightblue')
  mtext(names(main_data)[i], cex = 0.8, side = 1, line = 2)
}

dev.off()

pairs.panels(main_data)

ggcorrplot(cor(main_data), hc.order = TRUE,show.diag = FALSE,type="lower",lab=TRUE,insig = "blank",digits = 2,lab_size=3,colors= c("#6D9EC1", "white", "#E46726"))+ 
  labs(title = "Correlation Matrix")

#Avg life expect
df %>% group_by(Status) %>%  summarise_at(vars(Life.expectancy), list(Life.expectancy = mean)) %>%
  ggplot(aes(x=Status,y=Life.expectancy))+
  geom_bar(aes(fill=Status),stat='identity')+labs(title="Average Life Expectancy of countries")


#Top 10 countries with lowest life expectancy
df %>% group_by(Country) %>%  
  summarise_at(vars(Life.expectancy), list(Life.expectancy = mean)) %>% 
  filter(rank((Life.expectancy))<=10) %>%
  mutate(Country = fct_reorder(Country, Life.expectancy)) %>%
  ggplot(aes(x=Country,y=Life.expectancy))+
  geom_bar(aes(fill=Country),stat='identity')+labs(title="Top 10 countries with Lowest Life expectancy")



#Top 5 countries with highest life expectancy 
df %>% group_by(Country) %>%  
  summarise_at(vars(Life.expectancy), list(Life.expectancy = mean)) %>% 
  filter(rank(desc(Life.expectancy))<=10) %>%
  mutate(Country = fct_reorder(Country, desc(Life.expectancy))) %>%
  ggplot(aes(x=Country,y=Life.expectancy))+
  geom_bar(aes(fill=Country),stat='identity')+
  labs(title="Top 10 countries with Highest Life expectancy")

#Checking avg life expectancy of developing and developed

df %>% group_by(Year,Status) %>%  
  summarise_at(vars(Life.expectancy),list(Life.expectancy = mean)) %>%
ggplot(aes(x=Year, y=Life.expectancy, group=Status,color=Status)) + 
  labs(title = "Average Life Expectancy(2010-2015)")+
  geom_line()+geom_smooth(method=lm)+theme(axis.text.y = element_text(angle = 90, vjust = 0.5, hjust=1))+
  facet_wrap(~ Status)

#Modeling

full.model <- lm(Life.expectancy ~., data = main_data)
summary(full.model)

#lm.mod = lm(Life.expectancy~.-Year-Hepatitis.B-Polio-HIV.AIDS-GDP-thinness..1.19.years-thinness.5.9.years, data=main_data);


bwd=step(lm.mod,direction="backward")
bwd
summary(bwd)

regfit.full=regsubsets(Life.expectancy~.,main_data,nvmax = 20)
(reg.summary = summary(regfit.full))
which.min(reg.summary$rss) 
which.max(reg.summary$adjr2)
which.min(reg.summary$cp)
which.min(reg.summary$bic)


coef(regfit.full,8)
fit2 = lm(Life.expectancy~Adult.Mortality+Measles+under.five.deaths+Total.expenditure+Diphtheria+HIV.AIDS+Income.composition.of.resources+Population.y,main_data)
summary(fit2)


df2$continent <- countrycode(sourcevar = df2[, "Country"],
                              origin = "country.name",
                              destination = "continent")

df2<- as.tibble(df)

ggcorrplot(cor(main_data), hc.order = TRUE,show.diag = FALSE,type="lower",lab=TRUE,insig = "blank",digits = 2,lab_size=3,colors= c("#6D9EC1", "white", "#E46726"))+ 
  labs(title = "Correlation Matrix")

fit_all = regsubsets(Life.expectancy ~ ., main_data,nvmax = 19)
fit_all_sum = summary(fit_all)
names(fit_all_sum)

par(mfrow = c(2, 2))
plot(fit_all_sum$rss, xlab = "Number of Variables", ylab = "RSS", type = "b")

plot(fit_all_sum$adjr2, xlab = "Number of Variables", ylab = "Adjusted RSq", type = "b")
best_adj_r2 = which.max(fit_all_sum$adjr2)
points(best_adj_r2, fit_all_sum$adjr2[best_adj_r2],
       col = "red",cex = 2, pch = 20)

plot(fit_all_sum$cp, xlab = "Number of Variables", ylab = "Cp", type = 'b')
best_cp = which.min(fit_all_sum$cp)
points(best_cp, fit_all_sum$cp[best_cp], 
       col = "red", cex = 2, pch = 20)

plot(fit_all_sum$bic, xlab = "Number of Variables", ylab = "BIC", type = 'b')
best_bic = which.min(fit_all_sum$bic)
points(best_bic, fit_all_sum$bic[best_bic], 
       col = "red", cex = 2, pch = 20)

coef(fit_all, which.min(fit_all_sum$bic))


fit_fwd = regsubsets(Life.expectancy ~ ., data = main_data, nvmax = 20, method = "forward")
fit_fwd_sum = summary(fit_fwd)
which.min(fit_fwd_sum$bic)
which.min(fit_fwd_sum$cp)
which.min(fit_fwd_sum$adjr2)
which.min(fit_fwd_sum$rss)

fit_bwd = regsubsets(Life.expectancy ~ ., data = main_data, nvmax = 20, method = "backward")
fit_bwd_sum= summary(fit_fwd)
which.min(fit_bwd_sum$bic)
which.min(fit_bwd_sum$cp)
which.min(fit_bwd_sum$adjr2)
which.min(fit_bwd_sum$rss)

pairs.panels(main_data)

ggcorrplot(cor(main_data), hc.order = TRUE,show.diag = FALSE,type="lower",lab=TRUE,insig = "blank",digits = 2,lab_size=3,colors= c("#6D9EC1", "white", "#E46726"))+ 
  labs(title = "Correlation Matrix")

