# R >= 3.3.0
# Load packages
if (!require(needs)) install.packages("needs")
needs(readr, plyr, dplyr, ggplot2, nortest, dunn.test)

# Constants
DATA_PATH <- "data"
R_PATH <- "R"

# Source necessary files
source(file.path(R_PATH, "data_functions.R"))
source(file.path(R_PATH, "exploratory_analysis_functions.R"))

# Read the data into the workspace
pns13 <- read_csv(file.path(DATA_PATH, "DADOS_BRUTOS_PNS_2013.csv"))
pns13 <- preProcessPNS13(pns13)

## Exploratory Analysis -------------------------
# Sample size for each group
tapply(pns13$Q003, pns13$Instrucao, length)

# Any missing values?
tapply(pns13$Q003, pns13$Instrucao, function(x) any(is.na(x)))  # No

# Summary for each group
tapply(pns13$Q003, pns13$Instrucao, summary)

# Histograms, boxplots, and qqplots for the age variable for different
# levels of education
educationLevelHistogram(pns13)
educationLevelBoxplot(pns13)
educationLevelQQplot(pns13)

## Tests ----------------------------------------
# Lilliefors (K-S) test for normality
tapply(pns13$Q003, pns13$Instrucao, lillie.test)

# As none of the groups follow a normal distribution, we employ the
# Fligner-Killeen test for homogeneity of variance (homoscedasticity)
fligner.test(Q003 ~ Instrucao, data = pns13)

# As the assumptions of normality and homoscedasticity do not hold, 
# we employ the Kruskal-Wallis H test
kruskal.test(Q003 ~ Instrucao, data = pns13)

# Finally, as the Kruskal-Wallis H test found a statistically significant 
# difference between the means of the groups, we conduct a Dunn post-hoc test
dt_results <- dunn.test(pns13$Q003, pns13$Instrucao, method = "Bonferroni")
dt_results$comparisons[dt_results$P.adjusted < 0.01]  # 99% confidence level
dt_results$comparisons[dt_results$P.adjusted < 0.05]  # 95% confidence level

# The final results are:
# Under a 99% confidence level, there are statistically significant differences 
# between "Sem Instrucao - Fundamental", "Sem Instrucao - Medio", 
# "Sem Instrucao - Superior", and "Medio - Superior".
# Under a 95% confidence level, there are statistically significant 
# differences between "Sem Instrucao - Fundamental", "Sem Instrucao - Medio", 
# "Fundamental - Medio", "Sem Instrucao - Superior", and "Medio - Superior".
