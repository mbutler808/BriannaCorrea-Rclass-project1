# Processing Script Redo Correa
#
# This script will take our raw Palmer's Penguin data, process and clean it 
# and then save it as an Rds file in the Processed_data folder

## ---- Initial Setup --------
# Load necessary packages
library(dplyr)    # Data processing and cleaning
library(tidyr)    # Data tidying and reshaping
library(skimr)    # Summary statistics and data visualization
library(ggplot2)  # Data visualization with ggplot
library(here)     # Simplified file path management


## ---- Data Loading --------
penguin_raw <- read.csv(here("Data", "Raw_data", "penguin_raw_dirty.csv"), check.names = FALSE)

# Check data dictionary
file_path <- here("Data", "Raw_data", "datadictionary.csv")  # Fixed the file path
dictionary <- read.csv(file_path)
print(dictionary)

# Glimpse and summary of the data
dplyr::glimpse(penguin_raw)
summary(penguin_raw)
head(penguin_raw)
skimr::skim(penguin_raw)

orig_names <- names(penguin_raw)

# New column names
new_names <- c("study", "sampleN", "species", "region", "island", "stage", "id", "clutch", "eggdate", "culmenL", "culmenD", "flipperL", "mass", "sex", "d15N", "d13C", "comments")
names(penguin_raw) <- new_names  # Apply new names

# Histogram of raw data
hist(penguin_raw$mass, main = "Histogram of Body Mass (g)", xlab = "Body Mass (g)", col = "orange", breaks = 30)

# Bivariate plot for raw data
plot(penguin_raw$mass, penguin_raw$culmenL, main = "Body Mass vs. Culmen Length", xlab = "Body Mass (g)", ylab = "Culmen Length (mm)", col = "green", pch = 20)

# Cleaning: Fix species names
d1 <- penguin_raw
names(d1) <- new_names  # Renaming the data to shorter names

# Fixing typos in species names
d1$species[d1$species %in% c("Pengufn", "PeOguin", "AdeKie", "AdelieMPenguin")] <- "Adelie Penguin (Pygoscelis adeliae)"
d1$species[d1$species == "Ventoo"] <- "Gentoo Penguin (Pygoscelis papua)"

# Standardize species names
d1$species <- gsub(" penguin", " Penguin", d1$species)

# Clean the Culmen Length column
cl <- d1$culmenL
cl[cl == "missing"] <- NA  # Replace "missing" with NA
cl <- gsub("[^0-9.]", "", cl)  # Remove non-numeric characters
cl <- as.numeric(cl)

# Ensure number of rows match after coercion
if (length(cl) == nrow(d1)) {
  d1$culmenL <- cl
} else {
  warning("The number of rows doesn't match!")
}

# Skim the data after cleaning
skimr::skim(d1)

# Histogram of Culmen Length after cleaning
hist(d1$culmenL, col = "turquoise")

# Remove rows with missing values in Culmen Length or Body Mass
d1_clean <- d1[!is.na(d1$culmenL) & !is.na(d1$mass), ]

# Further clean the Culmen Length column for outliers
cl <- d1_clean$culmenL
outliers <- cl > 300
cat("Outliers greater than 300:", sum(outliers), "\n")

# Scale down outlier values by dividing by 10
cl[outliers] <- cl[outliers] / 10
d1_clean$culmenL <- cl

# Plot histogram after cleaning
hist(d1_clean$culmenL, main = "Histogram of Culmen Length (mm)", col = "lightblue", breaks = 30)

# Clean Body Mass (g) by removing unrealistic values (e.g., values < 100)
mm <- d1_clean$mass
mm[mm < 100] <- NA
nas <- which(is.na(mm))
d1_clean <- d1_clean[-nas, ]

# Skim data after cleaning Body Mass
skimr::skim(d1_clean)
hist(d1_clean$mass)

# Plot Body Mass vs. Culmen Length after cleaning
plot(d1_clean$mass, d1_clean$culmenL, main = "Body Mass vs. Culmen Length", col = "green", pch = 20)

# Convert categorical variables to factors
d1_clean$species <- as.factor(d1_clean$species)
d1_clean$sex <- as.factor(d1_clean$sex)
d1_clean$island <- as.factor(d1_clean$island)

# Final skim after all cleaning
skimr::skim(d1_clean)

## ---- bivariate plots --------
# Bivariate plots of each numeric variable with mass to check for further issues

# Plot Body Mass vs. Culmen Length
plot(d1_clean$mass, d1_clean$culmenL, xlab = "Body Mass (g)", ylab = "Culmen Length (mm)", main = "Body Mass vs. Culmen Length")

# Plot Body Mass vs. Culmen Depth
plot(d1_clean$mass, d1_clean$culmenD, xlab = "Body Mass (g)", ylab = "Culmen Depth (mm)", main = "Body Mass vs. Culmen Depth")

# Plot Body Mass vs. Flipper Length
plot(d1_clean$mass, d1_clean$flipperL, xlab = "Body Mass (g)", ylab = "Flipper Length (mm)", main = "Body Mass vs. Flipper Length")

# Plot Body Mass vs. Nitrogen Isotope (d15N)
plot(d1_clean$mass, d1_clean$d15N, xlab = "Body Mass (g)", ylab = "Nitrogen Isotope (d15N)", main = "Body Mass vs. Nitrogen Isotope (d15N)")

# Plot Body Mass vs. Carbon Isotope (d13C)
plot(d1_clean$mass, d1_clean$d13C, xlab = "Body Mass (g)", ylab = "Carbon Isotope (d13C)", main = "Body Mass vs. Carbon Isotope (d13C)")

## ---- histograms --------
# We will not subset by region, stage, eggdate, or sampleN as they have limited values

# Mass histogram (single plot)
hist(d1_clean$mass)

# Mass histogram by species
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_histogram(aes(fill = species), alpha = .5) +
  ggtitle("Mass Histogram by Species")

# Mass density by species
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_density(aes(fill = species), alpha = .5) +
  ggtitle("Mass Density by Species")

# Mass histogram by island
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_histogram(aes(fill = island), alpha = .5) + 
  ggtitle("Mass Histogram by Island")

# Mass density by island
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_density(aes(fill = island), alpha = .5) + 
  ggtitle("Mass Density by Island")

# Mass histogram by clutch
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_histogram(aes(fill = clutch), alpha = .5) + 
  ggtitle("Mass Histogram by Clutch")

# Mass density by clutch
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_density(aes(fill = clutch), alpha = .5) + 
  ggtitle("Mass Density by Clutch")

# Mass histogram by sex
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_histogram(aes(fill = sex), alpha = .5) + 
  ggtitle("Mass Histogram by Sex")

# Mass density by sex
d1_clean %>% ggplot(aes(x = mass)) + 
  geom_density(aes(fill = sex), alpha = .5) + 
  ggtitle("Mass Density by Sex")

## ---- finalizedata --------
# Finalize the cleaned dataset and save relevant variables

vars <- c("id", "species", "island", "clutch", "eggdate", "culmenL", "culmenD", 
          "flipperL", "mass", "sex", "d15N", "d13C")

penguin_clean <- d1_clean[vars]   # Save only the variables in 'vars'
names(penguin_clean) <- orig_names[vars]  # Revert to original names
print(orig_names[vars])

# Drop unused variables from the dictionary
dictionary <- dictionary[dictionary$variable %in% orig_names[vars],]  # Keep only relevant variables

# Print the updated dictionary
print(dictionary)

# Save cleaned dataset
saveRDS(penguin_clean, file = here("Data", "Processed_data", "penguin_clean.rds"))

cat("Data processing and cleaning is complete! :)")
