##############################
# Penguin Analysis Script: Question 3
# Is there a relationship between body mass and flipper length?
##############################

# Load required libraries
library(here)     # For making code more portable
library(ggplot2)  # For plotting
library(dplyr)    # For data manipulation

# Load the data using here() to make it portable
data_path <- here("Data", "Processed_data", "processeddata.rds")
dat <- readRDS(data_path)

# View the first few rows of the data to understand its structure
head(dat)

# Clean the data: Remove rows with NAs in 'Body Mass (g)' or 'Flipper Length (mm)'
dat_clean <- dat %>%
  filter(!is.na(`Body Mass (g)`) & !is.na(`Flipper Length (mm)`))

# Perform linear regression to test the relationship between body mass and flipper length
lm_fit <- lm(`Body Mass (g)` ~ `Flipper Length (mm)`, data = dat_clean)

# Summary of the model
summary(lm_fit)

# Create a scatter plot for Body Mass vs Flipper Length, with a regression line
ggplot(dat_clean, aes(x = `Flipper Length (mm)`, y = `Body Mass (g)`)) +
  geom_point(aes(color = Species), size = 2, alpha = 0.7) +    # Add points with species color
  geom_smooth(method = "lm", se = FALSE, color = "blue") +      # Add regression line
  labs(title = "Relationship between Body Mass and Flipper Length",
       x = "Flipper Length (mm)", y = "Body Mass (g)") +
  theme_minimal()

# Save the plot to a file
ggsave(filename = here("Results", "body_mass_vs_flipper_length.png"))

# Save the regression model to a file
saveRDS(lm_fit, file = here("Results", "body_mass_vs_flipper_length_model.rds"))

# Print summary message
message("The regression results show the relationship between body mass and flipper length. 
If the p-value is less than 0.05, it suggests that there is a statistically significant relationship 
between body mass and flipper length.")

# Print confirmation message
print("Script has run successfully! :)")
