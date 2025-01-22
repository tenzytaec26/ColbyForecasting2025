read_observations = function(scientificname = "Cetorhinus maximus",
                             minimum_year = 1970, 
                             ...){
  
  #' Read raw OBIS data and then filter it
  #' 
  #' @param scientificname chr, the name of the species to read
  #' @param minimum_year num, the earliest year of observation to accept or 
  #'   set to NULL to skip
  #' @return a filtered table of observations
  
  # Happy coding!
  
  # read in the raw data
  obs = read_obis(scientificname, ...)
  
  # Print initial summary
  #print("Raw data preview:")
  #print(summary(obs))
  
  dim_start = dim(obs)
  
  #print("Initial count of basisOfRecord:")
  #print(obs |> count(basisOfRecord))
  
  # Remove rows where eventDate is missing
  obs = obs |> 
    filter(!is.na(eventDate))
  
  # Debugging: Show an example row with missing individualCount before filtering
  #missing_individual_count = obs |> filter(is.na(individualCount)) |> slice(1)
  
  # Remove rows where individualCount is missing
  obs = obs |> 
    filter(!is.na(individualCount))
  
  obs = obs |>
    filter(!is.na(year))
  
  obs = obs |> 
    filter(!is.na(month))
 
  # Apply filtering by year if minimum_year is provided
  if (!is.null(minimum_year)){
    obs = obs |> 
      filter(year >= minimum_year)
  }
  
  obs = obs |> 
    filter(!(basisOfRecord %in% c("Preserved Specimen", "Nomenclature Specimen")))
  
  
  # Final summary
  #print("Final summary of observations:")
  #print(summary(obs))
  
  return(obs)
}


