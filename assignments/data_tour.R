source("setup.R")
db = brickman_database()
species = "Cetorhinus maximus"
basking= fetch_obis(scientificname = species)


# getting a summary of obs
ggplot(data = filtered_basking,                                
       mapping = aes(x = month)) +                 
  geom_bar() +                                    
  labs(title = "Monthly Basking Sharks Observations")  

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
