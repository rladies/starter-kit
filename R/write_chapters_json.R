
data <- read.csv("Current-Chapters.csv", header = TRUE)
names(data) <- tolower(names(data))

data <- unique(data)

data <- dplyr::arrange(data, country, city)
data$organizers <- gsub("\n", " ", data$organizers )
data$organizers <- strsplit(data$organizers, ", ")

# remove urls for accounts
data$twitter <- gsub("https://twitter.com/|/", "", data$twitter)
data$instagram <- gsub("https://www.instagram.com/|/", "", data$instagram)
data$facebook <- gsub("https://www.facebook.com/|/", "", data$facebook)
data$periscope <- gsub("https://www.periscope.tv/|/", "", data$periscope)
data$youtube <- gsub("https://www.youtube.com/|/", "", data$youtube)
data$github <- gsub("https://github.com/|/", "", data$github)
data$meetup <- gsub("https://www.meetup.com/|/", "", data$meetup)

# replace empty cells with NA
data[data == ""] <- NA

# place socials in a nested list
data <- dplyr::nest_by(data, country, state.region, 
                city, meetup, organizers,
                email, status, slack, 
                .key = "socials")

data <- dplyr::nest_by(data, country, .key = "chapters")
data$n_chapters <- sapply(data$chapters, nrow)

jsonlite::write_json(data, 
                     file.path("jsons", "chapters.json"), 
                     pretty = TRUE)

