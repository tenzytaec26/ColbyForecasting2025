source("setup.R")
db = brickman_database()
species = "Hemitripterus americanus"
redsea_raven = fetch_obis(scientificname = species)


# getting a summary of obs
ggplot(data = redsea_raven,                                
       mapping = aes(x = month)) +                 
  geom_bar() +                                    
  labs(title = "Monthly Red Sea Raven Observations")  

ggsave("images/monthly_redsea_raven.png")

ggplot(data = redsea_raven, mapping = aes(x = year)) + geom_bar() + 
  labs(title = "Yearly Red Sea Raven Observations")

ggsave("images/yearly_redsea_raven.png")


ggplot(data = redsea_raven) +       # create a plot object
  geom_sf(alpha = 0.1,      # add the points with some tweaking of appearance
          size = 0.7) +  
  geom_sf(data = coast,     # add the coastline
          col = "orange")

ggsave("images/onecoastline_redsea_raven.png")

ggplot(data = redsea_raven) +                  # create the plot
  geom_sf(alpha = 0.1, size = 0.7) +   # add the points
  geom_sf(data = coast,                # add the coast
          col = "orange") +
  facet_wrap(~month) 

ggsave("images/monthly_coastline_redsea_raven.png")
