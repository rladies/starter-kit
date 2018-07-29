#-----------------------------------------------------------#
# Goal: Update the "Current-Chapters.csv" programmatically
# Details about this script:
# 1) Update the meetup url
# 2) Filter chapters where status is prospect. Check it has a meetup url. 
# If it does then change the status to be active


# 'active'- has had an event in the last 4 months
# 'active quiet'- hasn't had an event in the last 4 months
# 'in-progress' - has a meetup account, is planning or has had its launch event 
# but is yet to have its first R training/presentation event.
# 'prospect' - is in the planning stage is not set up on meetup.com yet.
#-----------------------------------------------------------#

library(futile.logger)
library(data.table)
data <- fread("Current-Chapters.csv")



# add meetup url
add_meetup_url <- function(data, country, city, meetup_url) {
  # check if meetup_url is empty
  before <- data[(Country == country & City == city), ]
  if(before$Meetup %in% c("", NA)) {
    futile.logger::flog.info("Before", before, capture = TRUE)
    data[(Country == country & City == city), 
         `:=` (Meetup = meetup_url)]
    after <- data[(Country == country & City == city), ]
    futile.logger::flog.info("After", after, capture = TRUE)
    changed_column <- gsub(".*Column\\s*|:.*", "", all.equal(before, after))
    clean <- gsub("'", "", changed_column)
    futile.logger::flog.info("Change", after[, ..clean], capture = TRUE)
    data.table::fwrite(data, "Current-Chapters.csv")
  } else {
    stop("This chapter has a already meetup url.")
  }
}

# change status from Propective to Progress
change_status_to_progress <- function(data) {
  data[(!(Meetup %in% c("", NA)) & Status == "Prospective"), 
       `:=` (Status = "Progress")]
  data.table::fwrite(data, "Current-Chapters.csv")
}






