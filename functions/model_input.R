#' Reads a model input file given species, month, approach and path
#' 
#' @param scientificname chr, the species name
#' @param mon chr month abbreviation
#' @param approach chr, one of "greedy" or "conservative"
#' @param path chr the path to the data directory
read_model_input = function(scientificname = "Hemitripterus americanus",
                            mon = "Oct",
                            approach = "greedy",
                            path = data_path("model_input")){
  species = scientificname
  # your part goes in here
  if(approach == "greedy"){
    filename = sprintf("%s-%s-greedy_input.gpkg", 
            gsub(" ", "_", species),
            mon)
  }
  
  if(approach == "conservative"){
    filename = sprintf("%s-%s-conservative_input.gpkg", 
                   gsub(" ", "_", species),
                   mon)
  }
  path = data_path("model_input")
  full_path = file.path(path,filename)
  #print(path)
  #print(filename)
  x = read_sf(full_path)
  return(x)
  
}
