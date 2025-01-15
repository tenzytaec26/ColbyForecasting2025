DB = brickman_database() |>
  dplyr::filter(scenario == "RCP45", 
                year == 2055,
                interval == "mon")
x = read_brickman(db)

buoys = gom_buoys()

buoys = buoys |> 
  filter(id == "M01")


long_values = extract_brickman(x, buoys)

wide_values = extract_brickman(x, buoys, form = "wide")

