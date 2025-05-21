# Project Rubric - Project 1

Your audience is the user, members of the R-literate general public who may want to use your data and/or code. To be useful, the code and documentation must be clear enough to guide naive users in fully reproducing the analysis. Naive users may not know anything about the project, or may even be yourself after enough time has passed or projects multiplied! 

Elements:
1. Your github repo, organized following the project template.
2. Your modified code, quarto, and README files, organized in the repo.
2. Your output files (any requested output, i.e., `.csv`, `.html`, `.docx`, `.pdf` files) in their proper places in the repo.

|Criteria| Evaluation| Scoring | Points | Comments |
|:---------|:---|:---|:---|:---|
|__Right__| Code runs without Error - Must be YES | 0/10 |  5 | half credit for r script Yay! but qmd has errors.  |
|	  | Code produces correct output | 0-5 | 2 | |
|__Readable__| Code is readable (good use of white space, etc.) |0-5| 5  | |
|        | Code is understandable (good naming conventions, concise informative comments) |||  |
|__Reproducible__| READMEs document project organization | 0-5| 5 |  |
|        | READMEs explain the order to run the code/quarto in order to reproduce analysis| || |
|        | READMEs list contents of each directory | ||  |
|__Aesthetics__| Files are free of unnecessary clutter (assignment instructions, etc.) | 0-5 | 5 | |
|        | Code is elegant (not required, but a bonus) |  | | |
|__Bottom Line__| | 30 | 22 | |



Project 1:

processingcode.R Runs without error! YAY!!!

processingfile_v1.qmd

1. "---" has a special meaning in quarto, notice that it is part of the YAML header. Your quarto will not run properly with these sprinkled throughout the markdown. 
You must successfully run at the command line to produce the .html version:

quarto render processingfile_v1.qmd   

All of these "---" outside of the YAML header should be deleted because each one will cause an error. There are quite a few. 

Another hint is that in sublime, it has a color. That means it has special meaning in the syntax (i.e., itʻs not just regular text).  But truly, the errors should have told you something is wrong.

It can be hard to debug whe you have no idea. Thatʻs why itʻs best to start with a small piece that works and add bit by bit. You could have started with the working quarto code from the template and added.  Or delete most of it except for the header and the first few lines and see if that works, then add in bit by bit to narrow it down. Again, easiest to start small, check it works, then add a small piece, check that it works, and add bit by bit. 

2. Mismatch between the filename in your code vs. your filename in the folder. "penguins" vs "penguin"
data_location <- "../../Data/Raw_data/penguins_raw_dirty.csv"

Actual file name:
penguin_raw_dirty.csv  

If you were able to debug this file, it would look great! There is no .html provided with the repo. 
