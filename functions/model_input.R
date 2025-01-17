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
  
  # your part goes in here
  if(approach == "greedy"){
    x = sprintf("%s-%s-greedy_input.gpkg", 
            gsub(" ", "_", species),
            mon)
  }
  
  if(appraoch == "conservative"){
    x = sprintf("%s-%s-conservative_input.gpkg", 
                   gsub(" ", "_", species),
                   mon)
  }
  
  return(x)
  
}