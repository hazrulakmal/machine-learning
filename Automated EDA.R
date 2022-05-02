#It is undianiablly that EDA is an important part of any Data Science project workflow. It is a early for process to get our hands dirty with the data
#In this R Script, we will explore some R packages that facilitates this initial task  and provide substatial support in data handling, visualisng and reporting

library(tidyr)
library(readr)
library(dplyr)

data <- read_delim("src/cardio_train.csv", col_types = "iifidiiffffff",delim=";")
summary(data)
#pre-processing

data <- select(data, -id)  %>% 
  mutate(age = round(age/365))

head(data,5)

#-----Automated EDA packages------
#DataExplorer simplifies and automates the EDA process and report generation
library(DataExplorer)

data %>%
  create_report(
    output_file = paste("Report", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"), sep=" - "),
    report_title = "EDA Report - Cardiovascular Disease Dataset",
    y = "cardio"
  )

plot_bar(data)
plot_bar(data, by="cardio")
#by obeserving the plots, one may notice that patients with cardiovascular disease present higher values of cholesterol , and may be induced to further investigate the risk of 
# cardivascular disease represented by higher cholesterol values through statistical testings.

plot_qq(data)
plot_density(data)
plot_correlation(data)
plot_prcomp(data, variance_cap=0.6)

#GGaly
#use ggpairs to plot pairs plot showing the interactions between each variable with each of the others.

library(GGally)

# change plot size (optional)
options(repr.plot.width = 20, repr.plot.height = 10)

data %>% 
  select("age", "cholesterol", "height", "weight") %>%
  ggpairs(mapping = aes(color = data$cardio, alpha = 0.5))

#GGally provides an easy way to generate plots for discriptive analysis, proving useful for detecting anomolises, inspecting distributions and visually observe the differences between groups

library(SmartEDA)

# similarly, with dplyr syntax: df %>% ExpReport(...)
ExpReport(
  data,
  Target="cardio",
  label=NULL,
  op_file="Report.html",
  op_dir=getwd())

#In reality, data is messy so having a single line of code line this to visualise mostly all plots without a plot may be seen far-fetched
#perhaps, I can leverage the built-in function from these libraries to facilitate and speed up the EDA process
#Overall Good stuff!











