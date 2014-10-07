
#Your assignment: Find a web page and use the rvest package functions to pull at 
#least one piece of information from that web page.


#install.packages("devtools")
#library(devtools)
#install_github("hadley/rvest")
#library(rvest)

google_news = html("https://news.google.com/")
scraped <- html_nodes(google_news, ".esc-lead-article-title")
Google_News_Headlines<- html_text(scraped)

Google_News_Headlines
#ans

#[1] "Battle rages for Syrian border town"                                                  
#[2] "Ebola outbreak: Spanish nurse is first person to contract disease outside western ..."
#[3] "NHS funding crisis: Boss warns of £75-a-night charge for a hospital bed"              
#[4] "Twin Peaks: why there's never been anything like it"                                  
#[5] "Obama Vow on Ebola Screening Means Plugging Airport Gaps"                             
#[6] "Roy Keane lets rip at Sir Alex Ferguson in new book as he lifts lid on his stormy ..."
#[7] "Shrien Dewani's millionaire lifestyle revealed in detail as murder trial begins"      
#[8] "Mexico Disarms Police in Missing Students City"                                       
#[9] "Putin: Muzhik To Ears Of Ordinary Russians"                                           
#[10] "Teneriffe murder-suicide: Former friend describes Marcus Volke as paranoid, in ..."   
#[11] "IAEA To Meet Iranian Officials In Tehran"                                             
#[12] "Alice Gross murder: Man's body formally identified as prime suspect Arnis ..."        
#[13] "Ukip: Nigel Farage's plan to win eight seats"                                         
#[14] "Liberal Democrat conference: Swinson could be sole survivor of endangered ..."        
#[15] "Rio Tinto rejects talk of Glencore merger"                                            
#[16] "Libya's $1bn hangover – fund's losses after drinks with Goldman"                      
#[17] "Samsung: New Phones Amid 60% Profit Drop"                                             
#[18] "German industrial output plunges at fastest rate since 2009 financial crisis ..."     
#[19] "iPhone 6 'prototype' bids reach $100000"                                              
#[20] "AT&T fired employee who improperly accessed customer accounts"                        
#[21] "Tracey Emin: The Last Great Adventure is You review – a lesson in how to be a ..."    
#[22] "The Kitchen; Grantchester review – a domestic-espionage documentary and a ..."        
#[23] "Simon Cowell Is All About That Bass - Watch Simon Cover The Meghan Trainor Hit"       
#[24] "Pietersen: ECB used PR tricks"                                                        
#[25] "FA would consider taking foreign route again when replacing Hodgson"                  
#[26] "Bristol's latest green building opens today"                                          
#[27] "UN biodiversity report highlights failure to meet conservation targets"               
#[28] "Why this photograph isn't what it seems"                                              
#[29] "Honeysuckle tea could fight flu"                                                      
#[30] "Preschools Consider Requiring Flu Shots"                                              
#[31] "Cannabis 'addictive and causes mental health problems', 20 year study finds"  