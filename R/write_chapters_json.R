
data <- read.csv("Current-Chapters.csv", header = TRUE)
names(data) <- tolower(names(data))

data <- unique(data)

data <- dplyr::arrange(data, country, city)

# replace empty cells with NA
data[data == ""] <- NA

data <- dplyr::nest_by(data, country, .key = "chapters")

jsonlite::write_json(data, 
                     file.path("jsons", "chapters.json"), 
                     pretty = TRUE)

