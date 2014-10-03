# week6quiz.R
# [For your convenience], here is the provided code from Jared Lander's R for Everyone, 
# 6.7 Extract Data from Web Sites

install.packages("XML")
require(XML)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool

# 1. What type of data structure is bowlpool? 
# Answer: The data structure was pulled into R as a single dataframe

# 2. Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below

theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)

# What is the type of variable returned in hvalues?
# Answer: This data was pulled into R as a list of tables where each one is a data frame.

# 3. Write R code that shows how many HTML tables are represented in hvalues
amount_of_tables <-length(hvalues)
amount_of_tables
#Answer: 
#[1] 7

# 4. Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe
# Answer: The requested table is the first one, this is one of the ways to pull this table in:
hvalues_1 <- readHTMLTable(theURL)[[1]]

# 5. Modify the returned data frame so only the Last Name and Points columns are shown.
hvalues_1 <- subset(hvalues_1, select=c("Last Name", "Points"))

# 6 Identify another interesting page on the web with HTML table values.  
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files).  

myURL <- "http://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)"
gdp_per_country <- readHTMLTable(myURL)

# 7 How many HTML tables does that page contain?
amount_of_tables_in_my_URL <-length(gdp_per_country)
amount_of_tables_in_my_URL
#Answer: 
#[1] 13

# 8 Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.
# Answer: Im using Chrome browser (on a windows machine), in order to see source code, I right click on a page and hit "view page source".
