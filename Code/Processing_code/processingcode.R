###############################
# Processing Script Redo Correa
#
#This script will take our raw Palmer's Penguin data, process and cleans it 
# then save it as an Rds file in the Processed_data folder

## ---- Initial Setup --------
require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of the data 

## ---- Data Loading --------

data_location <- "../../Data/Raw_data/penguin_raw_dirty.csv"
data_path <- "../../Data/Raw_data"

# Read the data
penguin_raw <- read.csv(data_location, check.names=FALSE)

# Check data
file_path <- file.path(data_path, "datadictionary.csv", sep="")  # This looks fine for relative path
dictionary <- read.csv(file_path)
print(dictionary)

# Glimpse and summary of the data
dplyr::glimpse(penguin_raw)  # You can also use glimpse() directly if dplyr is loaded
summary(penguin_raw)
head(penguin_raw)
skimr::skim(penguin_raw)

orig_names <- names(penguin_raw)

new_names <- c("study", "sampleN", "species", "region", "island", "stage", "id", "clutch", "eggdate", "culmenL", "culmenD", "flipperL", "mass", "sex", "d15N", "d13C", "comments" )
names(orig_names) <- new_names   # label the original names vector with the new names

# Histogram of raw data
hist(penguin_raw$"Body Mass (g)", main="Histogram of Body Mass (g)", xlab="Body Mass (g)", col="orange", breaks=30)

# Bivariate plot for raw data
plot(penguin_raw$"Body Mass (g)", penguin_raw$"Culmen Length (mm)", main="Body Mass vs. Culmen Length", xlab="Body Mass (g)", ylab="Culmen Length (mm)", col="green", pch=20)

# Cleaning
unique(penguin_raw$Species)

d1 <- penguin_raw
names(d1)<- new_names #Renaming the data to the shorter names

ii <- grep("PengTin", d1$Species)  # Checking for correct case of column
d1$Species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"  # Ensure correct column name

# repeating for other misspelled species
ii <- grep("Pengufn", d1$Species)
d1$Species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"
unique(d1$Species)

ii <- grep("PeOguin", d1$Species)
d1$Species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"
unique(d1$Species)

ii <- grep("AdeKie", d1$Species)
d1$Species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"
unique(d1$Species)

ii <- grep("AdelieMPenguin", d1$Species)
d1$Species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"
unique(d1$Species)

ii <- grep("Ventoo", d1$Species)
d1$Species[ii] <- "Gentoo penguin (Pygoscelis papua)"
unique(d1$Species)

d1$Species <- gsub(" penguin", " Penguin", d1$Species)
unique(d1$Species)

# Species name shortening

# Clean the Culmen Length column and ensure it has the correct length

# Clean the Culmen Length column and ensure it has the correct length
cl <- d1$"Culmen Length (mm)"
cl[cl == "missing"] <- NA  # Replace "missing" with NA
cl <- gsub("[^0-9.]", "", cl)  # Remove any characters that are not digits or periods

# Check the length before coercion
print(length(cl))  # Should match number of rows in d1

# Coerce to numeric
cl <- as.numeric(cl)

# Check if the number of rows match
if(length(cl) == nrow(d1)) {
  d1$"Culmen Length (mm)" <- cl
} else {
  warning("The number of rows doesn't match!")
}

# Skim the data
skimr::skim(d1)

# Histogram of Culmen Length (mm) after cleaning
hist(d1$"Culmen Length (mm)", col= "turquoise")

# Remove rows where either Culmen Length or Body Mass is NA
d1_clean <- d1[!is.na(d1$"Culmen Length (mm)") & !is.na(d1$"Body Mass (g)"), ]

length(d1_clean$"Culmen Length (mm)")
length(d1_clean$"Body Mass (g)")

# Further clean the Culmen Length for outliers
cl <- d1_clean$"Culmen Length (mm)"

# Identify values greater than 300 and check them
#Since three of the penguins have impossible length culmens (300+)
#we can assume they are a typo and the way to fix this is

cl[ cl > 300 ] <- cl[ cl > 300 ] / 10 

cat("Outliers greater than 300:", sum(outliers), "\n")

# Modify the Culmen Length for outliers, dividing by 10
cl[outliers] <- cl[outliers] / 10  # Scale those values down

# Ensure no NA values when updating the dataframe
d1_clean$"Culmen Length (mm)" <- ifelse(is.na(cl), d1_clean$"Culmen Length (mm)", cl)

# Skim the cleaned data again after modifying Culmen Length
skimr::skim(d1_clean)

# Plot histogram after cleaning
hist(d1_clean$"Culmen Length (mm)", main="Histogram of Culmen Length (mm)", col="lightblue", breaks=30)

# Plot Body Mass vs. Culmen Length after final cleaning
plot(d1_clean$"Body Mass (g)", d1_clean$"Culmen Length (mm)", 
     main="Body Mass vs. Culmen Length", 
     xlab=orig_names["Body Mass (g)"], 
     ylab=orig_names["Culmen Length (mm)"], 
     col="green", pch=20)


# Plot after cleaning
plot(d1_clean[["Body Mass (g)"]], 
     d1_clean[["Culmen Length (mm)"]], 
     main="Body Mass vs. Culmen Length", 
     xlab=orig_names["Body Mass (g)"], 
     ylab=orig_names["Culmen Length (mm)"], 
     col="pink",        # Color for points
     pch=20,             # Type of points (solid circle)
     cex=2)              # Increase size of points for better visibility


# Identify values greater than 300 and check them

outliers <- cl > 300


cat("Outliers greater than 300:", sum(outliers), "\n")

# Modify the Culmen Length for outliers, dividing by 10
cl[outliers] <- cl[outliers] / 10  # Scale those values down

# Update the cleaned dataframe
d1_clean$"Culmen Length (mm)" <- cl

# Skim the cleaned data
skimr::skim(d1_clean)

# Plot histogram after cleaning
hist(d1_clean$"Culmen Length (mm)", main="Histogram of Culmen Length (mm)", col="lightblue", breaks=30)

# Skim the cleaned data
skimr::skim(d1_clean)
hist(d1_clean$"Culmen Length (mm)")

# Plot Body Mass vs. Culmen Length after final cleaning
plot(d1_clean$"Body Mass (g)", d1_clean$"Culmen Length (mm)", 
     main="Body Mass vs. Culmen Length", 
     xlab=orig_names["Body Mass (g)"], 
     ylab=orig_names["Culmen Length (mm)"], 
     col="green", pch=20)


# Clean Body Mass (g) by removing small values (adult data)
mm <- d1_clean$"Body Mass (g)"
mm[mm < 100] <- NA
nas <- which(is.na(mm))
d1_clean <- d1_clean[-nas, ]

# Skim the data after removing small masses
skimr::skim(d1_clean)
hist(d1_clean$"Body Mass (g)")

# Plot Body Mass vs. Culmen Length after removing small Body Mass
plot(d1_clean$"Body Mass (g)", d1_clean$"Culmen Length (mm)")

# Summary of cleaned data
summary(d1_clean$"Culmen Length (mm)")
summary(d1_clean$"Body Mass (g)")
skimr::skim(d1_clean)

# Convert categorical variables to factors
d1_clean$species <- as.factor(d1_clean$species)
d1_clean$sex <- as.factor(d1_clean$sex)
d1_clean$island <- as.factor(d1_clean$island)  

# Final skim after all cleaning
skimr::skim(d1_clean)

## ---- bivariateplots --------
# Bivariate plots of each numeric variable with mass to ensure there are no further errors:

# Plot Body Mass (g) vs. Culmen Length (mm)
plot(d1_clean$"Body Mass (g)", d1_clean$"Culmen Length (mm)", 
     xlab=orig_names["Body Mass (g)"], ylab=orig_names["Culmen Length (mm)"], 
     main="Body Mass vs. Culmen Length")

# Plot Body Mass (g) vs. Culmen Depth (mm)
plot(d1_clean$"Body Mass (g)", d1_clean$"Culmen Depth (mm)", 
     xlab=orig_names["Body Mass (g)"], ylab=orig_names["Culmen Depth (mm)"], 
     main="Body Mass vs. Culmen Depth")

# Plot Body Mass (g) vs. Flipper Length (mm)
plot(d1_clean$"Body Mass (g)", d1_clean$"Flipper Length (mm)", 
     xlab=orig_names["Body Mass (g)"], ylab=orig_names["Flipper Length (mm)"], 
     main="Body Mass vs. Flipper Length")

# Plot Body Mass (g) vs. Nitrogen Isotope (d15N)
plot(d1_clean$"Body Mass (g)", d1_clean$"d15N", 
     xlab=orig_names["Body Mass (g)"], ylab=orig_names["Nitrogen Isotope (d15N)"], 
     main="Body Mass vs. Nitrogen Isotope (d15N)")

# Plot Body Mass (g) vs. Carbon Isotope (d13C)
plot(d1_clean$"Body Mass (g)", d1_clean$"d13C", 
     xlab="Body Mass (g)", ylab="Carbon Isotope (d13C)", 
     main="Body Mass vs. Carbon Isotope (d13C)")

## ---- histograms --------

# We will not subset by region, stage as they have only 1 value
# nor eggdate and sampleN which have many values

require(ggplot2)

# Mass histogram (single plot)
hist(d1_clean$"Body Mass (g)")   # a single histogram of mass

# Mass histogram by species
d1_clean %>%   
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_histogram(aes(fill=Species), alpha=.5) +
    ggtitle("Mass Histogram by Species")

# Mass density by species
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_density(aes(fill=Species), alpha=.5) +
    ggtitle("Mass Density by Species")

# Mass histogram by island
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_histogram(aes(fill=Island), alpha=.5) + 
    ggtitle("Mass Histogram by Island")

# Mass density by island
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_density(aes(fill=Island), alpha=.5) + 
    ggtitle("Mass Density by Island")

# Mass histogram by clutch
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_histogram(aes(fill=Clutch), alpha=.5) + 
    ggtitle("Mass Histogram by Clutch")

# Mass density by clutch
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_density(aes(fill=Clutch), alpha=.5) + 
    ggtitle("Mass Density by Clutch")

# Mass histogram by sex
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_histogram(aes(fill=Sex), alpha=.5) + 
    ggtitle("Mass Histogram by Sex")

# Mass density by sex
d1_clean %>%    
    ggplot(aes(x=`Body Mass (g)`)) + 
    geom_density(aes(fill=Sex), alpha=.5) + 
    ggtitle("Mass Density by Sex")


## ---- finalizedata --------
# Finalize the cleaned dataset. 
# Save these variables

vars <- c("id", "Species", "Island", "Clutch", "Eggdate", "Culmen Length (mm)", "Culmen Depth (mm)", 
          "Flipper Length (mm)", "Body Mass (g)", "Sex", "d15N", "d13C")

penguin_clean <- d1_clean[vars]   # Save only the variables in vars
names(penguin_clean) <- orig_names[vars]  # Revert to original names
print(orig_names[vars])

# Drop unused variables from the dictionary
dictionary <- dictionary[dictionary$variable %in% orig_names[vars],]  # Keep only relevant variables

# Alternatively, drop unused rows using dplyr
dictionary <- dictionary %>% filter(variable %in% orig_names[vars])  # dplyr

# Print the updated dictionary
print(dictionary)

# Save data
processeddata <- d1_clean

save_data_location <- "../../Data/Processed_data/processeddata.rds"
saveRDS(processeddata, file = save_data_location)

save_data_location_csv <- "../../Data/Processed_data/processeddata.csv"
write.csv(processeddata, file = save_data_location_csv, row.names=FALSE)

# Notes
#Background of Palmer Penguin Data:
##The Palmer Penguin Study collects data on three species of penguins (Adélie, Chinstrap, and Gentoo) in Antarctica to understand their physical traits and how they adapt to their environment. This data is used for both scientific research on penguin populations and as a teaching tool for data analysis techniques.
#Saving data as RDS:
##I suggest you save your processed and cleaned data as RDS or RDA/Rdata files.  This preserves coding like factors, characters, numeric, etc.  If you save as CSV, that information would get lost.
#However, CSV is better for sharing with others since it's plain text.


