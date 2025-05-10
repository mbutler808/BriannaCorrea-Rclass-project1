# Code Folder

## Code Location:

Scripts will be placed in `.R` or `.qmd` scripts in the following folders:

- Processing_code is for cleaning raw data to processed data (Project 1)
- Analysis_code or your analyses on cleaned data (Project 2)


## Code Design:

The processing_code script is one large script that does many things but mainly is in charge of preliminary data checks and cleaning.

These will all use relative pathways. 

## Documentation for processing_data Script:

* PURPOSE: Cleaning and processing raw data for analysis
* Input: Raw data file: ../Data/Raw_data/penguin_raw_dirty.csv"
* Output: Processed data file: ../Data/Processed_data/processeddata.csv"

Aided in removing missing values, standardizing columns, names, filtered outliers. Allowed for the preparation of the dataset for the analysis that addresses questions in regards to the manuscript. 

## Documentation for Analysis_code

* PURPOSE: Calculates and summarizes key statistics for the penguin dataset in relation to the questions posed in the ReadMe.md ("../../Code/Analysis_code/README.md")

* Input:
- Initial Dataset: penguins.rds
- Cleaned Dataset: processeddata.rds

* Output:
- Summary Stats: summary_table.rds
- Stat Modeling: body_mass_vs_flipper_length_model.rds
- ANOVA Stat Model: flipper_length_species_anova.rds
- Sex and Body Mass Model: body_mass_sex_species_lm.rds
- Stat on Mass by Species: mass_species_anova.rds
- ANOVA on Mass by Island and Species: mass_species_island_anova.rds

* Images/Graphs:
- Mass and Species Density Plot: mass_species_density.png
- Mass, Species, and Island Density Plot: mass_species_island_density.png
- Mass by Species Bar Plot: mass_species_bars.png
- Density of Mass by Island: density_mass_by_island.png
- Histogram of Mass by Island: hist_mass_by_island.png
- Density of Mass by Species: density_mass_by_species.png
- Histogram of Mass by Species: hist_mass_by_species.png
- Residuals Histogram (Generic Model): residuals_histogram.png
- Residuals Histogram (Sex + Species Model): residuals_histogram_sex_species.png
- Flipper Length by Species Boxplot: flipper_length_species_boxplot.png
- Body Mass by Sex Boxplot: body_mass_sex_boxplot.png
- Body Mass vs Flipper Length Scatterplot: body_mass_vs_flipper_length.png



## Order of Execution:

Run processingcode.R ("../Code/Processing_code/processingcode.R")(Data Processing and Cleaning) first to prepare the data.

Run q1_flip_leng.R ("../Code/Analysis_code/q1_flip_leng.R")(Summary Statistics) to calculate descriptive stats and create visual summaries.

Run q2_sex_mass.R ("../Code/Analysis_code/q2_sex_mass.R") (Model Analysis) to conduct statistical modeling and fit relevant models.

Run q3_flip_mass.R ("../Code/Analysis_code/q3_flip_mass.R") (Exploratory Visualization) last to generate visualizations based on the clean and analyzed data.

