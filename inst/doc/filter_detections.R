## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(filteRjsats)

## ----choose a directory and generate a list of files, echo=TRUE---------------
# Choose a Directory 
path <- system.file("extdata", package = "filteRjsats")

# List Files in Directory
file <- list.files(path = path, recursive = TRUE)

## ----assign timezone, echo=TRUE-----------------------------------------------
# Get a list of Time Zones
# Not Run
# OlsonNames()

# Set Time Zone
timezone <- "America/Los_Angeles"

## ----read a directory of raw jsats detection files, echo=TRUE-----------------
# Empty list to store dataframes
det_list <- list()

# Process each file in the list of files
for(i in 1:length(file)){
jsats_file <- read_jsats(path, file[i])
det_list[[i]] <- jsats_file
}

## ----get a list of reference tags, echo=TRUE----------------------------------
# Get a list of reference tags
reference_tags <- get_reference_tags()

## ----apply the prefilter to a list of raw detection files, echo=TRUE----------
# Empty list to store dataframes
pref_list <- list()

# Apply prefilter
for(i in 1:length(det_list)){
prefilter_file <- prefilter(det_list[[i]], reference_tags)
pref_list[[i]] <- prefilter_file
}

## ----get fish data, echo=TRUE-------------------------------------------------
# View all the fish fields
get_fish_fields()

# NOT RUN
# Choose important fields if don't want all fields, shown are the minimum
# important_fields <- c("fish_type","tag_id_hex",
#                       "fish_release_date", "release_location",
#                       "release_latitude", "release_longitude",
#                       "tag_pulse_rate_interval_nominal",
#                       "tag_warranty_life", "fish_length_type",
#                       "fish_length","fish_weight")

# Query ERDAPP for all tagged fish
fish <- get_tagged_fish()

## ----join fish data to detection dataframe, echo=TRUE-------------------------
# Empty list to store dataframes
fish_list <- list()

# Join fish data to detection and filter based on release date and battery
for(i in 1:length(pref_list)){
fish_file <- add_fish(pref_list[[i]], fish)
fish_list[[i]] <- fish_file
}

## ----apply the final filter, echo=TRUE----------------------------------------
# Empty list to store dataframes
final_list <- list()

# Apply the final 2 hit or 4 hit filter
for(i in 1:length(fish_list)){
final_filter <- second_filter_2h4h(fish_list[[i]])
final_list[[i]] <- final_filter
}

# NOT RUN
# Alternately apply a 4 hit filter
# for(i in 1:length(fish_list)){
# final_filter <- second_filter_4h(fish_list[[i]])
# final_list[[i]] <- final_filter
# }

## ----get receiver data, echo=TRUE---------------------------------------------
# View all the receiver metadata fields
get_rcvr_fields()

# NOT RUN
# # Choose important fields if don't want all fields, shown are the minimum
# rcvr_fields <- c("dep_id","receiver_serial_number","latitude","longitude",
#                  "receiver_location","receiver_river_km",
#                  "receiver_general_location","receiver_general_river_km",
#                  "receiver_beacon_id_hex", "receiver_start",
#                  "receiver_end")

#Get the receiver metadata
rcvr_data <- get_rcvr_data()

#Join the receiver metadata to the filtered detections
for(i in 1:length(final_list)){
  out <- join_rcvr_data(final_list[[i]], rcvr_data)
  final_list[[i]]
}

print(final_list[[1]])
print(final_list[[2]])

