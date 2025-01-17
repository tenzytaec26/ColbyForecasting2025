
buoys = gom_buoys()
coast = read_coastline()
db = brickman_database()

buoys = buoys |> 
  filter(id == "M01") 

db = db |> 
  filter(scenario == "RCP45", interval == "mon")

covars = read_brickman(db)

x = extract_brickman(covars, buoys, form = "wide")

x = x |> filter(var == "SST")

ggplot(data = x,
       mapping = aes(x = month, y = SST)) +
  geom_point() + 
  labs(title = "Temp difference at buoy N01")


