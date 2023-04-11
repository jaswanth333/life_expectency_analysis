# Lift Expecetency Analysis
## Abstract:
The World Health Organization (WHO) provides access to essential Health Indicators Data through the Open Data APIs, which provides guidance and framework for analysis, and planning to Governments and Private entities. This project is about analyzing a dataset consisting of historical life expectancy data from different countries and 18 related variables. The variables cover a variety of socio-economic parameters from GDP to schooling rates and from various disease statistics to mortality rates. The study was done in three parts, addressing a specific research question.
The first part talks about the distribution of data in various variables, second part found the most critical variables to regress life expectancy. In the last part, a principal component analysis was performed to see if the information from this dataset could be meaningfully conveyed with a smaller number of variables. The results showed that the model could reasonably estimate life expectancy using the first four principal components.
## About the Data:
The WHO Life Expectancy Data has the following features:
It has 21 variables and 2938 records with data for 183 Countries for years ranging from 2000-2015. For the sake of simplicity and recency, only data from 2010-2015 was considered for most of the analysis.
The following table shows the description of each variable for the WHO Life Expectancy Data:

|     S.No    |     Attribute              |     Information                                                                                               |
|-------------|----------------------------|---------------------------------------------------------------------------------------------------------------|
|     1       |     Country                |     Country                                                                                                   |
|     2       |     Year                   |     Year                                                                                                      |
|     3       |     Status                 |     Developed or Developing status                                                                            |
|     4       |     Life Expectancy        |     Age(years)                                                                                                |
|     5       |     Adult Mortality        |     Adult Mortality Rates of both sexes(probability of dying   between 15&60 years per 1000 population)       |
|     6       |     Infant Deaths          |     Number of Infant Deaths per 1000 population                                                               |
|     7       |     Alcohol                |     Alcohol, recorded per capita (15+) consumption (in liters   of pure alcohol)                              |
|     8       |     Percent Expenditure    |     Expenditure on health as a percentage of Gross Domestic   Product per capita(%)                           |
|     9       |     Hep B                  |     Hepatitis B (HepB) immunization coverage among 1-year   olds(%)                                           |
|     10      |     Measles                |     Number of reported measles cases per 1000 population                                                      |
|     11      |     BMI                    |     Average Body Mass Index of the entire population                                                          |
|     12      |     U-5 Deaths             |     Number of under-five deaths per 1000 population                                                           |
|     13      |     Polio                  |      Polio(Pol3)   immunization coverage among 1-year olds(%)                                                 |
|     14      |     Total Expenditure      |     General government expenditure on health as a percentage of   total government expenditure(%)             |
|     15      |     Diphtheria             |     Diphtheria tetanus toxoid and pertussis (DTP3) immunization   coverage among 1-year olds (%)              |
|     16      |     HIV/AIDS               |     Deaths per 1000 live births HIV/AIDS(0-4 years)                                                           |
|     17      |     GDP                    |     Gross Domestic Product per capita(in USD)                                                                 |
|     18      |     Population             |     Population Thinness 10-19- Prevalence of thinness among   children and adolescents for Age 10 to 19(%)    |
|     19      |     Thinness 5             |     Prevalence of thinness among children for Age 5 to 9(%)                                                   |
|     20      |     Income Composition     |     Human Development Index in terms of income composition of   resources(0                                   |
|     21      |     Schooling              |     Number of years of Schooling                                                                              |

## Research Question 1: What Factors play important role in determining the Life expectancy?
After fitting the linear regression model with Life expectancy as determining variable and all other as predicting variables, the results showed that health related variables such as Hepatitis, Polio, and thinness 10-19 years are not explaining the life expectancy very well. It also explains that variables such as Adult Mortality, Income composition of resources, HIV and Diphtheria and Schooling are major factors in determining the life expectancy as the p-value is less than 2e-16 rejecting the null hypothesis.

## Research Question 2: Is it possible to use PCA to make prediction about life expectancy? 
A research question that can be asked about this dataset is that if it is possible to gain a prospective of life expectancy in different countries if the life expectancy column was not included in the dataset. Too address this in a simple way, countries were categorized in two groups. In this dataset the mean life expectancy is 71.21 years and the median is 73.30 years, and countries were categorized into countries with life expectancy over 70 years and the ones with life expectancy of below 70 years. The result is visualized on a map.
