# Load packages
library(needs)
needs(readr, dplyr, ggplot2)

# Constants
DATA_PATH <- "data"
R_PATH <- "R"

# Source necessary files
source(file.path(R_PATH, "data_functions.R"))
source(file.path(R_PATH, "exploratory_analysis_functions.R"))

# Read the data into the workspace
pns13 <- read_csv(file.path(DATA_PATH, "DADOS_BRUTOS_PNS_2013.csv"))
pns13 <- preProcessPNS13(pns13)

# Exploratory Analysis -------------------------
educationLevelHistogram(pns13)
educationLevelBoxplot(pns13)