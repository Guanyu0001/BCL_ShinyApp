# BCL APP
This is an interactive app to help users select beverages they like by type and price. The results can be downloaded.

You will find 6 files in the repository: "app.R", "bcl-data.csv", "BCL.Rproj", "README.md", ".gitignore", ".gitattributes"

- app.R is the code for this shiny app. For browsing, click the app.R file. For running code, you can open Rstudio and start a new project by the link, or just download the Rmd file and run it in Studio.
- bcl-data.csv is the data file for this app.
- BCL.Rproj contains project options and can also be used as a shortcut for opening the project directly from the file system.
- README.md contains a thorough description of the content that can be found in this repository.
- .gitignore specifies intentionally untracked files that Git should ignore.
- .gitattributes is a simple text file that gives attributes to pathnames.

## Updates
This new version v0.2.0 was updated for the following considerations:

- App design

    It is easy for the user to understand how the app is supposed to be used and also for the user to use the app with the introduction and feedback.
    * Update the description of the app, and provide the introduction of each widget.
    * Add a linear break and a bold title to each widget.
    * Add a textbox for demonstrating the current input of each widget.

- Code mastery

    A minimal amount of code and dependencies are used (code efficiency):
    * Reactive expressions were used.
    * There is no redundant code. 
    
    Note that the if-else statement is used for descending the records by price. Given that only `desc()` works with `arrange()`, this is the best way I can achieve the sorting now. Besides, I have asked TA for a better solution. But the feedback about providing `descending = TURE` does not work for both  `desc()` and `arrange()`,  and the reactive expression (i.e., `filtered()`) is different from a data frame, which means the approaches of sorting for data frame can be used here.


## Online URL
https://guanyu.shinyapps.io/BCL_guanyu/

## Option
My choice is Option A - BC Liquor app.

## Description for the Difference
1. One new functional widget that modifies at least one output.
- The checkbox with the label "Descending by price" was added to sort the table by price.
2. One change to the UI (aside from the addition of a widget).
- Use the DT package to turn a static table into an interactive table.
- Allow the user to search for multiple entries simultaneously. All types of beverages were checked as default.
3. A third feature, whether it’s a change to the UI or a functional widget.
- Show the number of results found whenever the filters change. 
- Allow the users to download the custom table not the full table as a .csv file. In this case, it will be very helpful for them to save their selection.

## Dataset
The data can be found here: https://deanattali.com/files/bcl-data.csv. This data is from Dean Attali’s tutorial for a shiny app: https://deanattali.com/blog/building-shiny-apps-tutorial/. Thanks for sharing.
