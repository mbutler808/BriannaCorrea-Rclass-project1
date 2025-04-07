##############################
# Penguin Analysis Script: Question 1
# How does flipper length vary by species?
##############################

# Load required packages
library(here)     # For making code more portable
library(ggplot2)  # For plotting
library(dplyr)    # For data manipulation

# Load the data
# Use already cleaned data

data_path <- "Processed_data/"
dat <- readRDS(paste0(data_path, "processeddata.rds"))

# View the first few rows of the data to understand its structure
head(dat)

# Create a boxplot to visualize the flipper length by species
ggplot(dat, aes(x = Species, y = `Flipper Length (mm)`, fill = Species)) + 
  geom_boxplot() +
  labs(title = "Flipper Length by Species", 
       x = "Species", 
       y = "Flipper Length (mm)") +
  theme_minimal()

# Save the plot to a file
ggsave(filename = "../../Results/flipper_length_species_boxplot.png")

# Perform ANOVA to test if flipper length differs by species
lm_fit <- lm(`Flipper Length (mm)` ~ Species, data = dat)
anova_result <- anova(lm_fit)

# Print the ANOVA result to screen
print(anova_result)

# Save the ANOVA result to a file
saveRDS(anova_result, file = "../../Results/flipper_length_species_anova.rds")

# Optionally, check assumptions of ANOVA (normality and homogeneity of variance)
# Checking normality: Plot histogram of residuals
residuals <- lm_fit$residuals
ggplot(data.frame(residuals), aes(x = residuals)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Residuals Histogram", x = "Residuals", y = "Frequency") +
  theme_minimal()

# Save residuals histogram to a file
ggsave(filename = "../../Results/residuals_histogram.png")

# Checking homogeneity of variance: Use Levene's Test (if needed)
library(car)
leveneTest(`Flipper Length (mm)` ~ Species, data = dat)

# Summary message for the analysis
message("The ANOVA results indicate whether there is a statistically significant difference in flipper length between species. 
If the p-value is less than 0.05, it suggests that species differ significantly in their flipper lengths.")

print("Script has run successfully! :)")
