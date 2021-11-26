# BCL APP
This is a interactive app to help user select beverages they like by types and prices. The results can be downloaded.

You will find 6 files in the repository: "app.R", "bcl-data.csv", "BCL.Rproj", "README.md", ".gitignore", ".gitattributes"

- app.R is the code for this shiny app. For browsing, click the app.R file. For running code, you can open Rstudio and start a new project by the link, or just download the Rmd file and run it in Studio.
- bcl-data.csv is the data file for this app.
- BCL.Rproj contains project options and can also be used as a shortcut for opening the project directly from the file system.
- README.md contains a thorough description on the content that can be found in this repository.
- .gitignore specifies intentionally untracked files that Git should ignore.
- .gitattributes is a simple text file that gives attributes to pathnames.


## Online URL
https://guanyu.shinyapps.io/BCL_guanyu/

## Option
My choice is Option A - BC Liquor app.

## Description for the Difference
1. One new functional widget that modifies at least one output.
- The checkbox with label "Dscending by price" was added to sort the table by price.
2. One change to the UI (aside from the addition of a widget).
- Use the DT package to turn a static table into an interactive table.
- Allow the user to search for multiple entries simultaneously. All types of beverages were checked as default.
3. A third feature, whether it’s a change to the UI, or a functional widget.
- Show the number of results found whenever the filters change. 
- Allow the users to download the custom table not the full table as a .csv file. In this case, it will be very helpful for them save their selection.

## Dataset
The data can be found here: https://deanattali.com/files/bcl-data.csv. This data is from Dean Attali’s tutorial for shiny app: https://deanattali.com/blog/building-shiny-apps-tutorial/. Thanks for sharing.
