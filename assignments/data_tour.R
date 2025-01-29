source("setup.R")
db = brickman_database()
species = "Cetorhinus maximus"
basking= fetch_obis(scientificname = species)
filtered_basking = read_observations()

filtered_basking = filtered_basking |>
  mutate(month = factor(month, levels = month.abb))

# Plot the monthly observations with properly ordered months
ggplot(data = filtered_basking,                                
       mapping = aes(x = month)) +                 
  geom_bar() +                                    
  labs(title = "Monthly Basking Sharks Observations",
       x = "Month",
       y = "Number of Observations") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate month labels for clarity

# Save the plot
ggsave("images/monthly_basking.png")

ggplot(data = filtered_basking, mapping = aes(x = year)) + geom_bar() + 
  labs(title = "Yearly Basking Sharks Observations")

ggsave("images/yearly_basking.png")

coast = read_coastline()
ggplot(data = filtered_basking) +       # create a plot object
  geom_sf(alpha = 0.1,      # add the points with some tweaking of appearance
          size = 0.7) +  
  geom_sf(data = coast,     # add the coastline
          col = "orange")

ggsave("images/onecoastline_basking.png")

ggplot(data = filtered_basking) +                  # create the plot
  geom_sf(alpha = 0.1, size = 0.7) +   # add the points
  geom_sf(data = coast,                # add the coast
          col = "orange") +
  facet_wrap(~month) 

ggsave("images/monthly_coastline_basking.png")
