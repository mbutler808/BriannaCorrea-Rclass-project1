
# Code Folder

## Code Location:

Scripts are placed in `.R` or `.qmd` files located in the following folders:

- **Processing_code**: Scripts for cleaning raw data to processed data (Project 1).
- **Analysis_code**: Scripts for analysis on the cleaned data (Project 2).

## Code Design:

- The `processing_code` script is a comprehensive script responsible for preliminary data checks and cleaning.
- All scripts utilize relative paths for file references.

## Documentation for `processing_data` Script:

* **Purpose**: Cleaning and processing raw data for analysis.
* **Input**: Raw data file: `../Data/Raw_data/penguin_raw_dirty.csv`
* **Output**: Processed data file: `../Data/Processed_data/processeddata.csv`

This script handles the following tasks:
- Removes missing values.
- Standardizes column names.
- Filters outliers.
- Prepares the dataset for analysis by addressing questions posed in the project manuscript.

## Documentation for `Analysis_code`:

* **Purpose**: Calculates and summarizes key statistics for the penguin dataset in relation to the questions outlined in the README.
* **Input**:
  - Initial Dataset: `penguins.rds`
  - Cleaned Dataset: `processeddata.rds`
* **Output**:
  - Summary Statistics: `summary_table.rds`
  - Statistical Modeling:
    - `body_mass_vs_flipper_length_model.rds`
    - `flipper_length_species_anova.rds`
    - `body_mass_sex_species_lm.rds`
    - `mass_species_anova.rds`
    - `mass_species_island_anova.rds`
* **Images/Graphs**:
  - Mass and Species Density Plot: `mass_species_density.png`
  - Mass, Species, and Island Density Plot: `mass_species_island_density.png`
  - Mass by Species Bar Plot: `mass_species_bars.png`
  - Density of Mass by Island: `density_mass_by_island.png`
  - Histogram of Mass by Island: `hist_mass_by_island.png`
  - Density of Mass by Species: `density_mass_by_species.png`
  - Histogram of Mass by Species: `hist_mass_by_species.png`
  - Residuals Histogram (Generic Model): `residuals_histogram.png`
  - Residuals Histogram (Sex + Species Model): `residuals_histogram_sex_species.png`
  - Flipper Length by Species Boxplot: `flipper_length_species_boxplot.png`
  - Body Mass by Sex Boxplot: `body_mass_sex_boxplot.png`
  - Body Mass vs Flipper Length Scatterplot: `body_mass_vs_flipper_length.png`

## Order of Execution:

1. **Run the `processingcode.R`** (`../Code/Processing_code/processingcode.R`) to process and clean the data.
   
2. Once data processing is complete, refer to the README file in **Analysis_code** for detailed instructions on how to execute the analysis scripts.

3. The analysis scripts should be run in the following order:
   
   - **Run `q1_flip_leng.R`** (`../Code/Analysis_code/q1_flip_leng.R`) to calculate summary statistics and generate visual summaries.
   - **Run `q2_sex_mass.R`** (`../Code/Analysis_code/q2_sex_mass.R`) to conduct statistical modeling and fit relevant models.
   - **Run `q3_flip_mass.R`** (`../Code/Analysis_code/q3_flip_mass.R`) last to generate exploratory visualizations based on the cleaned and analyzed data.

---
