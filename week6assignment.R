
#Your assignment: Find a web page and use the rvest package functions to pull at 
#least one piece of information from that web page.


#install.packages("devtools")
#library(devtools)
#install_github("hadley/rvest")
#library(rvest)

url = "http://office.microsoft.com/en-us/buy-microsoft-office-2013-suites-and-office-365-subscriptions-FX102886268.aspx"
x = html(url)
list <- html_nodes(x, ".pmgTxtFs24 , .heading5")
scraped_data <- html_text(list)
df <- data.frame(scraped_data)

#removing unneccessary data
ptn = "{.*?"
ndx = grep(ptn, df$scraped_data, perl = T, invert=T)
list_of_microsoft_office_products <- as.character(df[ndx,])
list_of_microsoft_office_products

# ans: [1] "Word"       "Excel"      "PowerPoint" "OneNote"    "Outlook"    "Publisher"  "Access" 

