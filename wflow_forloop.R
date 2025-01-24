months = month.abb
background_approach = c("greedy" , "conservative")


for (m in months){
  for (ba in background_approach){
    model_input_path = paste0("~/Desktop/2025/karmathinley/model_input/Cetorhinus_maximus-", m, "-", ba, "_input.gpkg")
    
    if (!file.exists(model_input_path)) {
      warning(paste("Model input file is missing for month:", m))
      next
    }
  
    model_input = read_model_input( mon = m, approach = ba)
    #version_name = paste0("g_", m)
    if (ba == "greedy"){
      version_path = paste0("g_",m)
      cfg = read_configuration(version = version_path)
    }
    if (ba == "conservative"){
      version_path = paste0("c_",m)
      cfg = read_configuration(version = version_path)
    }
    
    
    db = brickman_database()
    
    covars = read_brickman(db |> filter(scenario == "PRESENT", interval == "mon"))|>
      select(all_of(cfg$keep_vars))
    
    all_data = prep_model_data(model_input, 
                               month = m,
                               covars = covars, 
                               form = "table") |>
      select(all_of(c("class", cfg$keep_vars)))
    
    split_data = initial_split(all_data, 
                               prop = 3/4,
                               strata = class)
    wflow = workflow()
    
    tr_data = training(split_data)
    
    rec = recipe(class ~ ., data = slice(tr_data,1))
    
    rec = rec |> 
      step_naomit()
    
    if ("depth" %in% cfg$keep_vars){
      rec = rec |>
        step_log(depth,  base = 10)
    }
    
    if ("Xbtm" %in% cfg$keep_vars){
      rec = rec |>
        step_log(Xbtm,  base = 10)
    }
    
    rec = rec |> 
      step_corr(all_numeric_predictors())
    
    wflow = wflow |>
      add_recipe(rec)
    
    model = rand_forest() |>
      set_mode("classification") |>
      set_engine("ranger", probability = TRUE, importance = "permutation") 
    
    wflow = wflow |>
      add_model(model)
    
    fitted_wflow = fit(wflow, data = tr_data)
    # print(cfg$version)
    write_workflow(fitted_wflow, version = cfg$version)
  
  }
  
}
