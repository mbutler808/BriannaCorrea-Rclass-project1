###############################
# Processing Script Redo Correa
#
#This script will take our raw Palmer's Penguin data, process and cleans it 
# then save it as an Rds file in the Processed_data folder

# Initial Setup
#require(dplyr) #for data processing/cleaning
#require(tidyr) #for data processing/cleaning
#require(skimr) #for nice visualization of data 

library(dplyr)   # Package for data manipulation
library(tidyr)   # Package for tidying and reshaping data to visualize
library(skimr)   # Package for summarizing data to account for missing or incorrect values

# Data loading

data_location <- "../../Data/Raw_data/penguins_raw_dirty.csv"
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

# Histogram of raw data
hist(penguin_raw$"Body Mass (g)", main="Histogram of Body Mass (g)", xlab="Body Mass (g)", col="orange", breaks=30)

# Bivariate plot for raw data
plot(penguin_raw$"Body Mass (g)", penguin_raw$"Culmen Length (mm)", main="Body Mass vs. Culmen Length", xlab="Body Mass (g)", ylab="Culmen Length (mm)", col="green", pch=20)

# Cleaning
unique(penguin_raw$Species)

d1 <- penguin_raw

ii <- grep("PengTin", d1$Species)
d1$Species[ii] <- "Adelie Penguin (Pygoscelis adeliae)"

# repeat for other misspelled species
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

# Remove rows where either Culmen Length or Body Mass is NA
d1_clean <- d1[!is.na(d1$"Culmen Length (mm)") & !is.na(d1$"Body Mass (g)"), ]

# Further clean the Culmen Length for outliers
cl <- d1_clean$"Culmen Length (mm)"

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

# Plot Body Mass vs. Culmen Length after final cleaning
plot(d1_clean$"Body Mass (g)", d1_clean$"Culmen Length (mm)", 
     main="Body Mass vs. Culmen Length", 
     xlab="Body Mass (g)", 
     ylab="Culmen Length (mm)", 
     col="green", pch=20)


# Plot after cleaning
plot(d1_clean[["Body Mass (g)"]], 
     d1_clean[["Culmen Length (mm)"]], 
     main="Body Mass vs. Culmen Length", 
     xlab="Body Mass (g)", 
     ylab="Culmen Length (mm)", 
     col="green",        # Color for points
     pch=20,             # Type of points (solid circle)
     cex=2)              # Increase size of points for better visibility

# Further clean the Culmen Length for outliers
cl <- d1_clean$"Culmen Length (mm)"





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
     xlab="Body Mass (g)", 
     ylab="Culmen Length (mm)", 
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
d1_clean$Species <- as.factor(d1_clean$Species)
d1_clean$Sex <- as.factor(d1_clean$Sex)
d1_clean$Island <- as.factor(d1_clean$Island)  

# Final skim after all cleaning
skimr::skim(d1_clean)

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


