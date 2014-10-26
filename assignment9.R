#####Part 2: rmongodb#####
#Once you have successfully created the above database, 
#you need to read the data into R. Research 
#the rmongodb package and use it to pull the data into 
#R as three separate data frames (one each for
#states, districts, and territiories). Make sure you do 
#any necessary cleanup on the data so that it is 
#ready to hand off to a colleague to work with!
  

####IMPORT INTO R####
library(rmongodb)
library(plyr)

# connect to MongoDB
mongo = mongo.create(host = "localhost")

# Store name of DB and collection to be imported
mongo_data = 'unitedstates.data'

# create empty data frames that will be populated with the data, one for each data set
state_data = data.frame(stringsAsFactors = F)
territory_data = data.frame(stringsAsFactors = F)
district_data = data.frame(stringsAsFactors = F)

# create a cursor for reading the data that will be iterated over
# until we reach the end of the collection
cursor = mongo.find(mongo, mongo_data)

# set i equal to 1 to begin iterating
i=1

# iterate over each row and insert into an empty df
# check which dataset this comes from (state, territory, district)
# and then bind that row with the previous rows imported
# this will continue until we reach the end of the the records

while (mongo.cursor.next(cursor)) {
  tmp = mongo.bson.to.list(mongo.cursor.value(cursor))
  tmp.df = as.data.frame(t(unlist(tmp)), stringsAsFactors = F)
  if (is.null(tmp.df$state) == FALSE) {
    state_data = rbind.fill(state_data, tmp.df) 
  }
  else if (is.null(tmp.df$territory)== FALSE) {
    territory_data = rbind.fill(territory_data, tmp.df)
  }
  else {
    district_data = rbind.fill(district_data, tmp.df) 
  }
}
####CLEANUP####

# remove _id from the data
state_data = state_data[,-1]
territory_data = territory_data[,-1]
district_data = district_data[,-1]

# Format dates
state_data$statehood_date = as.Date(state_data$statehood_date, format = "%m/%d/%Y")
district_data$establishment_date = as.Date(district_data$establishment_date, format = "%m/%d/%Y")

# Remove quotes from territorial status
territory_data$territorial_status = sub('"', '', territory_data$territorial_status)
territory_data$territorial_status = sub('"', '', territory_data$territorial_status)

# Separate territorial status into 2 columns
list = strsplit(territory_data$territorial_status,",")
list_df = ldply(list)
territory_data$incorporated_status = list_df$V1
territory_data$organizational_status = list_df$V2
territory_data = territory_data[,-5]

