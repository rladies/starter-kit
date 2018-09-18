#-----------------------------------------------------------#
# Goal: Update the social medias from "Current-Chapters.csv" programmatically
# Details about this script:
# 1) Update the social media 
# (Twitter Facebook Instagram Periscope Youtube GitHub Website Slack)
# function: add_social_media

library(futile.logger)
library(data.table)
data <- fread("Current-Chapters.csv")



# add social media url
add_social_media <- function(data, country, city, 
                             social_media = c("Twitter",
                                              "Facebook",
                                              "Instagram",
                                              "Periscope",
                                              "Youtube",
                                              "GitHub",
                                              "Website",
                                              "Slack"),
                             social_media_url) {
  social_media <- match.arg(social_media)
  # check if specific social media is empty
  before <- data[(Country == country & City == city), ]
  if(before[[social_media]] %in% c("", NA)) {
    futile.logger::flog.info(" ============= BEFORE =============", 
                             before, capture = TRUE)
    data[(Country == country & City == city), 
         (social_media):= social_media_url]
    after <- data[(Country == country & City == city), ]
    futile.logger::flog.info(" ============= AFTER =============", 
                             after, capture = TRUE)
    changed_column <- gsub(".*Column\\s*|:.*", "", all.equal(before, after))
    clean <- gsub("'", "", changed_column)
    futile.logger::flog.info(" ============= CHANGE =============", 
                             after[, ..clean], capture = TRUE)
    data.table::fwrite(data, "Current-Chapters.csv")
  } else {
    stop("This chapter has already this social media url you are trying to add.")
  }
}

# Example
# add_social_media(data, "Canada", "Toronto", "Twitter", "https://twitter.com/rladiestoronto")
# add_social_media(data, "Canada", "Toronto", "Slack", "rladiestoronto.slack.com")


