write_chapters <- function(){
  data <- read.csv("Current-Chapters.csv", header = TRUE)
  names(data) <- tolower(names(data))
  
  # replace empty cells with NA
  data[data == ""] <- NA
  
  data <- dplyr::nest_by(data, country, .key = "chapters")
  
  jsonlite::write_json(data, 
                       "chapters.json", 
                       pretty = TRUE)
}
