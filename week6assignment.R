
#Your assignment: Find a web page and use the rvest package functions to pull at 
#least one piece of information from that web page.


install.packages("devtools")
library(devtools)
install_github("hadley/rvest")
library(rvest)

url2 = "http://office.microsoft.com/en-us/buy-microsoft-office-2013-suites-and-office-365-subscriptions-FX102886268.aspx"
x2 = html(url2)
list2 <- html_nodes(x2, ".pmgTxtFs24 , .heading5")
a2<- html_text(list2)
a3 <- data.frame(a2)

ptn = "{.*?"
ndx = grep(ptn, a3$a2, perl = T, invert=T)
list_of_microsoft_office_products <- as.character(a3[ndx,])
list_of_microsoft_office_products

# ans: [1] "Word"       "Excel"      "PowerPoint" "OneNote"    "Outlook"    "Publisher"  "Access" 
