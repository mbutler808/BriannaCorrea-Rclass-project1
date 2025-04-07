##############################
# Penguin Analysis Script: Question 2
# Does sex predict body mass when controlling for species?
##############################

# Load required libraries
library(here)     # For making code more portable
library(ggplot2)  # For plotting
library(dplyr)    # For data manipulation
library(car)      # For the Levene's test

# Load the data using here() to make it portable
data_path <- here("Data", "Processed_data", "processeddata.rds")
dat <- readRDS(data_path)

# View the first few rows of the data to understand its structure
head(dat)

# Perform linear regression to test if sex predicts body mass while controlling for species
lm_fit <- lm(`Body Mass (g)` ~ Sex + Species, data = dat)

# Summary of the model
summary(lm_fit)

# Create a plot for Body Mass by Sex
ggplot(dat, aes(x = Sex, y = `Body Mass (g)`, fill = Sex)) +
  geom_boxplot() +
  labs(title = "Body Mass by Sex", x = "Sex", y = "Body Mass (g)") +
  theme_minimal()

# Save the plot to a file
ggsave(filename = here("Results", "body_mass_sex_boxplot.png"))

# Save the model result to a file
saveRDS(lm_fit, file = here("Results", "body_mass_sex_model.rds"))

# Perform Levene's test for homogeneity of variance
levene_test_result <- leveneTest(`Body Mass (g)` ~ Sex * Species, data = dat)

# Print the Levene's test result
print(levene_test_result)

# Print summary message
message("The regression results indicate whether sex predicts body mass when controlling for species. 
If the p-value is less than 0.05, it suggests that sex significantly predicts body mass.")

# Print confirmation message
print("Script has run successfully! :)")
