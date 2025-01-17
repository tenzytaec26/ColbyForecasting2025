source("setup.R")

SPECIES = "Hemitripterus americanus"

obs = read_obis(SPECIES)
obs

dim_start = dim(obs)
dim_start

obs |> count(basisOfRecord)

summary(obs)

obs = obs |>
  filter(!is.na(eventDate))

summary(obs)

obs |>
  filter(is.na(individualCount)) |>
  slice(1) |>
  browse_obis()

obs = obs |>
  filter(!is.na(individualCount))

summary(obs)

obs = obs |>
  filter(year >= 1970)

dim(obs)

ggplot(data = obs,
       mapping = aes(x = year)) + 
  geom_bar() + 
  geom_vline(xintercept = c(1982, 2013), linetype = "dashed") + 
  labs(title = "Counts per year")

obs = obs |>
  mutate(month = factor(month, levels = month.abb))

ggplot(data = obs,
       mapping = aes(x = month)) + 
  geom_bar() + 
  labs(title = "Counts per month")


db = brickman_database() |>
  filter(scenario == "STATIC", var == "mask")
mask = read_brickman(db, add_depth = FALSE)
mask

plot(mask, breaks = "equal", axes = TRUE, reset = FALSE)
plot(st_geometry(obs), pch = ".", add = TRUE)

hitOrMiss = extract_brickman(mask, obs)
hitOrMiss

count(hitOrMiss, value)

obs = obs |>
  filter(!is.na(hitOrMiss$value))
dim_end = dim(obs)

dropped_records = dim_start[1] - dim_end[1]
dropped_records

