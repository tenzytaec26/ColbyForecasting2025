months_list = c("Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec")
condition_list = c("RCP45" , "RCP85")

for (mon in months_list){
  
  for (con in condition_list){
    version_name = paste0("g_" , mon)
    
    cfg = read_configuration(version = version_name)
    db = brickman_database()
    covars = read_brickman(db |> filter(scenario == "PRESENT", interval == "mon")) |>
      select(all_of(cfg$keep_vars)) |>
      slice("month", mon) 
    
    wflow = read_workflow(version = cfg$version)
    
    nowcast = predict_stars(wflow, covars)
    
    coast = read_coastline()
    
    covars_rcp85_2075 = read_brickman(db |> filter(scenario == con, year == 2075, interval == "mon")) |>
      select(all_of(cfg$keep_vars)) |>
      slice("month", mon) 
    
    forecast_2075 = predict_stars(wflow, covars_rcp85_2075)
    
    
    covars_rcp85_2055 = read_brickman(db |> filter(scenario == con, year == 2055, interval == "mon")) |>
      select(all_of(cfg$keep_vars)) |>
      slice("month", mon) 
    
    forecast_2055 = predict_stars(wflow, covars_rcp85_2055)
    
    path = data_path("predictions")
    if (!dir.exists(path)) ok = dir.create(path, recursive = TRUE)
    
    nowcast_filename = paste0("g_", mon, "_", con, "_2020.tif")
    forecast_2055_filename = paste0("g_", mon, "_", con, "_2055.tif")
    forecast_2075_filename = paste0("g_", mon, "_", con, "_2075.tif")
    rcp85_all_filename = paste0("g_", mon, "_", con, "_all.tif")
    
    # write individual arrays?
    write_prediction(nowcast, file = file.path(path, nowcast_filename))
    write_prediction(forecast_2055, file = file.path(path, forecast_2055_filename))
    write_prediction(forecast_2075, file = file.path(path, forecast_2075_filename))
    
  }
}
