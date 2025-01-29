process_month = function(month, config_version) {
  model_input = read_model_input(scientificname = "Cetorhinus maximus", 
                                 approach = "greedy", 
                                 mon = month)
  cfg = read_configuration(version = config_version)
  db = brickman_database()
  covars = read_brickman(db |> filter(scenario == "PRESENT", interval == "mon")) |>
    select(all_of(cfg$keep_vars))
  
  all_data = prep_model_data(model_input, 
                             month = month,
                             covars = covars, 
                             form = "table") |>
    select(all_of(c("class", cfg$keep_vars)))
  
  split_data = initial_split(all_data, prop = 3/4, strata = class)
  tr_data = training(split_data)
  
  rec = recipe(class ~ ., data = tr_data) |> 
    step_naomit()
  rec = rec |>
    step_corr(all_numeric_predictors())
  rec = rec |> 
    step_log(depth, base = 10)
  
  wflow = workflow() |> 
    add_recipe(rec) |> 
    add_model(rand_forest() |> 
                set_mode("classification") |> 
                set_engine("ranger", probability = TRUE, importance = "permutation"))
  
  fitted_wflow = fit(wflow, data = tr_data)
  
  # Predict on the training data
  predict_table(fitted_wflow, tr_data, type = "prob")
}

# Process each month
pred_may = process_month("May", "g_May")
pred_jun = process_month("Jun", "g_Jun")
pred_jul = process_month("Jul", "g_Jul")

# Combine predictions
combined_pred = rbind(pred_may, pred_jun, pred_jul)

# Compute average probabilities
average_pred = combined_pred |> 
  group_by(class) |> 
  summarize(across(starts_with(".pred"), mean))