
data <- read.csv("global-team.csv", header = TRUE)
names(data) <- tolower(names(data))


# replace empty cells with NA
data[data == ""] <- NA

# remove trailing and leading white space
data$role <- gsub("^ | $", "", data$role)
data$start <- gsub("^ | $", "", data$start)
data$end <- gsub("^ | $", "", data$end)

data <- unique(data)

# Make role into an array
data$role <- strsplit(data$role, "; ")

data <- dplyr::arrange(data, name)

jsonlite::write_json(data, 
                     file.path("jsons", "global-team.json"), 
                     pretty = TRUE)
