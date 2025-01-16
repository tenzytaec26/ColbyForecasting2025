# Setting up R
source("setup.R")

#setting up variables and datasets
buoys = gom_buoys()
coast = read_coastline()
db = brickman_database()

# Filtering the datasets
buoy_m01 = buoys |> filter(id == "M01")
## plot(buoys['id'], axes = TRUE, pch = 16)
##plot(coast, col = "orange", lwd = 2, axes = TRUE, reset = FALSE,
##     main = "Buoys in the Gulf of Maine")
##plot(st_geometry(buoys), pch = 1, cex = 0.5, add = TRUE)
##text(st_geometry(buoys), labels = buoys$id, cex = 0.7, adj = c(1,-0.1))

db = db |>
  filter(scenario == "RCP45", interval == "mon", year == "2055") # note the double '==', it's comparative
db
current = read_brickman(db)
current

#plot(current['SST'])

current_sst = current['SST']
current_sst

# Extracting point data from Brickman object, x=current_sst, y=buoy, and also has form
long_values = extract_brickman(current_sst, buoy_m01)
long_values = long_values |> 
  # mutate modify and delete columns also creates new columns, in this case, it is converting 
  # mutate into a factor with ordered levels. 
  mutate(month = parse_factor(month, levels = month.abb))

# Creating plot 
ggplot(data = long_values, aes(x = month, y = value)) + geom_point() + 
  labs(y = "SST(C)", 
       title = "RCP4.5 2055 SST at buoy M01")

