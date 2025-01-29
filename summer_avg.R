# Summer Average

# Load data for May, June, and July
covars_may = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "May")

covars_june = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "Jun")

covars_july = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "Jul")

# Make predictions for each month
pred_may = predict_stars(wflow, covars_may)
pred_june = predict_stars(wflow, covars_june)
pred_july = predict_stars(wflow, covars_july)


pred_presence_may = pred_may['.pred_presence']
pred_presence_june = pred_june['.pred_presence']
pred_presence_july = pred_july['.pred_presence']



# Combine the predictions along a new dimension
pred_combined = c(pred_presence_may, pred_presence_june, pred_presence_july, 
                  along = list(month = c("May", "June", "July")))

# Calculate the average across the "month" dimension
pred_avg = st_apply(pred_combined, c("x", "y"), mean)


# plot(pred_avg, main = "Average Prediction for May, June, and July", 
#      axes = TRUE, breaks = seq(0, 1, by = 0.1), reset = FALSE)
# plot(coast, col = "orange", lwd = 2, add = TRUE)
plot(pred_avg, 
     main = "Average Prediction for May, June, and July", 
     axes = TRUE, breaks = seq(0, 1, by = 0.1), 
     col = plasma_colors, reset = FALSE)
plot(coast, col = "orange", lwd = 2, add = TRUE)





# Winter Average
source("setup.R")
library(viridisLite)
plasma_colors = plasma(10)
# Load data for May, June, and July
covars_sep = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "Sep")

covars_oct = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "Oct")

covars_nov = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "Nov")

# Make predictions for each month
pred_sep = predict_stars(wflow, covars_sep)
pred_oct = predict_stars(wflow, covars_oct)
pred_nov = predict_stars(wflow, covars_nov)


pred_presence_sep = pred_sep['.pred_presence']
pred_presence_oct = pred_oct['.pred_presence']
pred_presence_nov = pred_nov['.pred_presence']



# Combine the predictions along a new dimension
pred_combined = c(pred_presence_sep, pred_presence_oct, pred_presence_nov, 
                  along = list(month = c("Sep", "Oct", "Nov")))

# Calculate the average across the "month" dimension
pred_avg = st_apply(pred_combined, c("x", "y"), mean)


# plot(pred_avg, main = "Average Prediction for Sep., Oct., and Nov.", 
#      axes = TRUE, breaks = seq(0, 1, by = 0.1), reset = FALSE)
# plot(coast, col = "orange", lwd = 2, add = TRUE)
plot(pred_avg, 
     main = "Average Prediction for Sep., Oct., and Nov.", 
     axes = TRUE, breaks = seq(0, 1, by = 0.1), 
     col = plasma_colors, reset = FALSE)
plot(coast, col = "orange", lwd = 2, add = TRUE)



# Load for June only
library(viridisLite)
plasma_colors = plasma(10)
covars_june = read_brickman(db |> filter(scenario == "RCP85", year == 2075, interval == "mon")) |>
  select(all_of(cfg$keep_vars)) |>
  slice("month", "Jun")

# Make predictions for June
# pred_may = predict_stars(wflow, covars_may)
pred_june = predict_stars(wflow, covars_june)

pred_presence_june = pred_june['.pred_presence']

# Plot the prediction for June
plot(pred_presence_june, 
     main = "Prediction for June (RCP85, 2075)", 
     axes = TRUE, breaks = seq(0, 1, by = 0.1), 
     col = plasma_colors, reset = FALSE)
plot(coast, col = "orange", lwd = 2, add = TRUE)
