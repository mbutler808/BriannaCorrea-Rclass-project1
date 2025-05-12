# Overview

![Palmer Penguin Party](Images/palmerpenguin.png)

This project is part of an R coding class focused on learning how to clean, analyze, and visualize externally provided data. It follows a structured approach using R, Quarto, and GitHub to promote reproducibility and good data science practices.

![Data science pipeline](https://github.com/mbutler808/rclass/blob/main/images/dspipeline.png)
[Figure: The Data Science Pipeline from RD Peng](https://rdpeng.github.io/Biostat776/lecture-the-data-science-pipeline.html)

# Project

The Palmer Penguin Project is a dataset used for ecological and statistical analysis, featuring three species of penguins: Adelie, Chinstrap, and Gentoo—collected from the Palmer Archipelago in Antarctica. The dataset includes measurements such as flipper length, bill depth, and body mass, along with categorical data like sex and species. It is often used as a cleaner, more intuitive alternative to the classic Iris dataset for machine learning and data visualization tasks. The project aims to support ecological research while serving as a valuable educational resource for data science and statistical modeling.

# History

- **2023-02-16**: First release with Data and Code folders with materials for data cleaning and initial exploration.
- **2025-03-01**: Cloned from M. Butler repo for R Class Spring 2025.
- **2025-03-20**: Original Submission by Brianna Correa with Data Cleaning Edits.
- **2025-04-01**: Currently under renovation for data cleaning.
- **2025-04-02**: Finished data cleaning, Project 2 underway.
- **2025-04-04**: Issues with laptop key stick, Project 2 questions formulated, .qmd edits made, script testing
- **2025-04-05**: Finalizing script, changing questions
- **2025-05-11**: Fixed script, approved readme.md and .qmds, Project 2 complete, script run without error after "source()" check. 

### Updates:
- Code now runs without issues, producing figures required for the project.
- Data has been processed and cleaned; bivariate plots and required histograms have been created to demonstrate the cleaned data.
- Corrections have been made to GitHub to match local files. The README file has been updated to reflect the project.
- Outliers are properly handled and documented.
- Packages are not recommended for download unless necessary.

# Acknowledgement

This is Brianna Correa's class project repository, based on a template cloned and modified from [https://github.com/andreashandel/dataanalysis-template](https://github.com/andreashandel/dataanalysis-template).

# Software Requirements

This template lays out a data analysis project and report writing using R, Quarto, GitHub, and a reference manager for BibTeX. A plain text editor is also necessary, and word-processing software to open `.docx` files if you wish to use that format (e.g., MS Word, MacOS Pages, or [LibreOffice](https://www.libreoffice.org/)).

For more R packages supporting reproducible research, check out the task view: [Reproducible Research on CRAN](https://cran.r-project.org/web/views/ReproducibleResearch.html).

# Template Structure

- **Data Folder**: Contains the dataset and any subfolders.
- **Code Folder**: Contains all code created, including relevant subfolders.
- Further modifications can be expected in the future.

# Template Content

- You will want to review the README.md files in the **Code** and **Data** folders for more details regarding the Palmer Penguins morphology and life history data we are utilizing.
- The **Processing_code** folder has the original raw data as well as the cleaned data.
- More updates related to **Project 2** will follow in the future.

# Getting Started

To begin, navigate to the **Code** folder. Inside, you'll find an additional README file that provides more information about the raw files and the cleaning process they undergo.

### Step 1: Processing Script
To start the cleaning process, open the **processing script** located at: ../../Code/Processing_code/processingcode.R

This script will guide you through the data cleaning process. Once finished, you will have a cleaned dataset ready for analysis. The cleaned data file will be saved as:clean_penguin_data.rds

### Step 2: Follow the Instructions
Inside the **processingcode.R** script, you'll find another README file that provides detailed instructions on the order in which you should process the various scripts. 

### Step 3: Analyze and Visualize
After completing the data cleaning, you will be able to generate several figures that provide insights into the three questions the project focuses on.
