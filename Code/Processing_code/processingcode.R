###############################
# Processing Script Redo Correa
#
# This script processes and cleans raw Palmer's Penguin data,
# then saves it as an Rds file in the Processed_data folder.
###############################

## ---- Initial Setup --------
library(dplyr)   # for data processing/cleaning
library(tidyr)   # for data processing/cleaning
library(skimr)   # for visual summaries
library(ggplot2) # for plots

## ---- Data Loading --------

data_location <- "../../Data/Raw_data/penguin_raw_dirty.csv"

data_path <- "../../Data/Raw_data"

penguin_raw <- read.csv("../../Data/Raw_data/penguin_raw_dirty.csv")


# Load and print dictionary
dictionary <- read.csv(file.path(data_path, "datadictionary.csv"))
print(dictionary)

# Preview raw data
glimpse(penguin_raw)
summary(penguin_raw)
head(penguin_raw)
skim(penguin_raw)

# ---- Renaming Columns ----
orig_names <- names(penguin_raw)
new_names <- c("study", "sampleN", "species", "region", "island", "stage", "id", "clutch", "eggdate",
               "culmenL", "culmenD", "flipperL", "mass", "sex", "d15N", "d13C", "comments")
names(penguin_raw) <- new_names

# ---- Initial Visualizations (Raw) ----
hist(penguin_raw$mass, main="Histogram of Body Mass (g)", xlab="Body Mass (g)", col="orange", breaks=30)
plot(penguin_raw$mass, penguin_raw$culmenL, main="Body Mass vs. Culmen Length",
     xlab="Body Mass (g)", ylab="Culmen Length (mm)", col="green", pch=20)

## ---- Data Cleaning --------

# Clean Species names
typo_map <- c("PengTin", "Pengufn", "PeOguin", "AdeKie", "AdelieMPenguin")
penguin_raw$species <- as.character(penguin_raw$species)
penguin_raw$species[penguin_raw$species %in% typo_map] <- "Adelie Penguin (Pygoscelis adeliae)"
penguin_raw$species[penguin_raw$species == "Ventoo"] <- "Gentoo Penguin (Pygoscelis papua)"
penguin_raw$species <- gsub(" penguin", " Penguin", penguin_raw$species)

# Clean Culmen Length
penguin_raw$culmenL <- as.character(penguin_raw$culmenL)
penguin_raw$culmenL[penguin_raw$culmenL == "missing"] <- NA
penguin_raw$culmenL <- as.numeric(gsub("[^0-9.]", "", penguin_raw$culmenL))

# Skim cleaned data and histogram
skim(penguin_raw)
hist(penguin_raw$culmenL, col = "turquoise", main = "Cleaned Culmen Length")

# ---- Remove Rows with NAs in key columns ----
d1_clean <- penguin_raw[!is.na(penguin_raw$culmenL) & !is.na(penguin_raw$mass), ]

# ---- Fix Impossible Culmen Length Values ( > 300 mm ) ----
d1_clean$culmenL[d1_clean$culmenL > 300] <- d1_clean$culmenL[d1_clean$culmenL > 300] / 10

# ---- Clean Body Mass: Remove Juvenile Penguins (< 100g) ----
d1_clean <- d1_clean[d1_clean$mass >= 100, ]

# ---- Final Checks ----
skim(d1_clean)
hist(d1_clean$culmenL, main = "Histogram of Culmen Length (mm)", col = "lightblue", breaks = 30)
hist(d1_clean$mass, main = "Histogram of Body Mass (g)", col = "orange")

# ---- Scatter Plot: Body Mass vs Culmen Length ----
plot(d1_clean$mass, d1_clean$culmenL,
     main = "Body Mass vs. Culmen Length",
     xlab = "Body Mass (g)", ylab = "Culmen Length (mm)",
     col = "green", pch = 20, cex = 2)

# ---- Convert Categorical Variables ----
d1_clean$species <- as.factor(d1_clean$species)
d1_clean$sex <- as.factor(d1_clean$sex)
d1_clean$island <- as.factor(d1_clean$island)

# ---- Bivariate Plots for Numeric Variables ----
numeric_vars <- c("culmenL", "culmenD", "flipperL", "d15N", "d13C")

for (var in numeric_vars) {
  plot(d1_clean$mass, d1_clean[[var]],
       xlab = "Body Mass (g)", ylab = var,
       main = paste("Body Mass vs.", var))
}

# ---- Histograms and Densities by Group ----

# By Species
p1 <- ggplot(d1_clean, aes(x = mass)) +
  geom_histogram(aes(fill = species), alpha = 0.5, bins = 30) +
  ggtitle("Mass Histogram by Species")
ggsave("../../Data/Processed_data/hist_mass_by_species.png", plot = p1)

p2 <- ggplot(d1_clean, aes(x = mass)) +
  geom_density(aes(fill = species), alpha = 0.5) +
  ggtitle("Mass Density by Species")
ggsave("../../Data/Processed_data/density_mass_by_species.png", plot = p2)

# By Island
p3 <- ggplot(d1_clean, aes(x = mass)) +
  geom_histogram(aes(fill = island), alpha = 0.5, bins = 30) +
  ggtitle("Mass Histogram by Island")
ggsave("../../Data/Processed_data/hist_mass_by_island.png", plot = p3)

p4 <- ggplot(d1_clean, aes(x = mass)) +
  geom_density(aes(fill = island), alpha = 0.5) +
  ggtitle("Mass Density by Island")
ggsave("../../Data/Processed_data/density_mass_by_island.png", plot = p4)

saveRDS(d1_clean, file = "../../Data/Processed_data/clean_penguin_data.rds")

