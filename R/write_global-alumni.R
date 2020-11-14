
data <- read.csv("global-team-alumni.csv", header = TRUE)
names(data) <- tolower(names(data))

data <- unique(data)


# remove trailing and leading white space
data$role <- gsub("^ | $", "", data$role)
data$start <- gsub("^ | $", "", data$start)
data$end <- gsub("^ | $", "", data$end)

# Make role into an array
data$role <- strsplit(data$role, "; ")

data <- dplyr::arrange(data, name, role)

# replace empty cells with NA
data[data == ""] <- NA

jsonlite::write_json(data, 
                     file.path("jsons", "global-team-alumni.json"), 
                     pretty = TRUE)

