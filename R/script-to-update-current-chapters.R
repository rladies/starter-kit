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


library(data.table)
data <- fread("Current-Chapters.csv")



# add meetup url
add_meetup_url <- function(data, country, city, meetup_url) {
  data[(Country == country & City == city), 
        `:=` (Meetup = meetup_url)]
  data.table::fwrite(data, "Current-Chapters.csv")
}

# change status from Propective to Progress
change_status_to_progress <- function(data) {
  data[(!(Meetup %in% c("", NA)) & Status == "Prospective"), 
       `:=` (Status = "Progress")]
  data.table::fwrite(data, "Current-Chapters.csv")
}
change_status_to_progress(data)





