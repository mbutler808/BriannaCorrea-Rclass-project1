
# Palmer Penguin Data Analysis Correa, Brianna

## Project Overview

This project analyzes data from the Palmer Penguins dataset. The analysis focuses on three questions related to penguin characteristics, with the goal of understanding how certain factors (e.g., sex, species, body mass, flipper length) affect penguin traits.

## Research Questions

1. **Does sex predict body mass when controlling for species?**
2. **Is there a relationship between body mass and flipper length?**
3. **Do foraging patterns differ by species or sex?** (or the adjusted question)

## How to Run the Analysis

To reproduce this analysis, follow these steps:

### Prerequisites

- Install R and the following R packages:

    ```r
    install.packages(c("here", "ggplot2", "dplyr", "car"))
    ```

### Steps to Run:

1. Clone this repository to your local machine or download the project.
2. Set the working directory to the project folder (or use `here()` for relative paths).
3. Run the individual R scripts in the following order using RStudio or R in the terminal:

    1. **First script** (`q1_sex_bodymass.r`):  
    ```r
    source("Code/Analysis_code/q1_sex_bodymass.r")
    ```
    This script tests whether sex predicts body mass when controlling for species.
    
    2. **Second script** (`q3_flipper_mass.r`):  
    ```r
    source("Code/Analysis_code/q3_flipper_mass.r")
    ```
    This script explores the relationship between body mass and flipper length.

    3. **Third script** (`q2_forg_patterns.r`):  
    ```r
    source("Code/Analysis_code/q2_forg_patterns.r")
    ```
    This script explores whether foraging patterns differ by species or sex (or the adjusted question).

### Output:
- Visualizations and statistical results will be saved in the `Results` folder, including plots and model summaries.

## About the Data

The dataset used for this analysis contains measurements of penguins from the Palmer Station, Antarctica, including characteristics like species, body mass, sex, flipper length, etc. The dataset can be found in the `Data/Processed_data` folder.

## Files Overview:
- Code/Analysis_code: Contains R scripts used for answering the research questions.
- Data/Processed_data: The cleaned dataset used for analysis.
- Results: Contains output from the analysis, including plots and model results.
- Manuscript: The final report written in Quarto Markdown.

## References
