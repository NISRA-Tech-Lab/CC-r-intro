# R: Not just for technical wizards
## NISRA Coffee and Coding - R and RStudio Introduction

### Setup 
- Download the .zip folder of this repo (green code button dropdown to top right, then select "Download ZIP").

- Unzip this folder to a location on your machine e.g. Desktop

- Open the folder and open the _"r-intro-coffee-coding.Rproj"_ file. This should open an instance of RStudio

- In your console (usually the left hand portion of the screen in RStudio), type and return `renv::restore()`, entering `Y` when prompted. You should see package installs being carried out in your console

  - Renv doesn't let the user know when installs are complete so try entering a simple calculation such as 2+2 in the console while the installs are happening and you will see the answer returned in the console when the installations are complete.
  
  - If you think your installs are done, type and return `renv::status()` in the console - you should see a message returned stating `No issues found -- the project is in a consistent state.`

- If the install flags up errors and stops:
  - You may not have access to the package repository needed to install packages within this project. Contact techlab@nisra.gov.uk for more info on this
  - You should still be able to run the scripts below up to the packages section, even without completed installs, as the earlier parts use BASE R code only

Open _"r-intro-coffee-coding.R"_ or _"r-intro-coffee-coding-in-person.R"_ and run through code
