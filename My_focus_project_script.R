#load packages
library(tidyverse)
library(ggplot2)
library(cowplot)

# load data
seaspurge <- read_csv("data/ss_data_focus.csv")

#view data
View(seaspurge)

head(seaspurge, 5)

# select heterozygosities and plot against each other
seaspurge %>% 
  select(pop_no, N, Ho, Hs) %>% 
  ggplot(aes(x = Ho, y = Hs, size = N)) +
  geom_point()

ss_no_se <- select(seaspurge, -Ho_se, -Hs_se, -Ar_se, -Fis_se)
View(ss_no_se)

#Plot 1: observed heterozygosity against gene diversity
plot1 <- seaspurge %>% 
  ggplot(aes(x = Ho, y = Hs, colour = state, size = N)) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Figure 1: Hs v Ho",
    x = "Observed heterozygosity (Ho)",
    y = "Observed gene diversity (Hs)")

plot1

#plot the observed heterozygosity for each population
plot2 <- seaspurge %>%
  ggplot(aes(x = pop_no, y = Ho, fill = state)) +
  geom_col() +
  labs(
    title = "Figure 2: Mean observed heterozygosity for each population",
    x = "Population number (pop_no)",
    y = "Observed heterozygosity (Ho)"
  )

plot2

#plot the number of private alleles
plot3 <- seaspurge %>% 
  ggplot(aes(x = state, y = Pa)) +
  geom_col() +
  labs(
    title = "Figure 3: Total number of private alleles across all populaitons within a State",
    x = "State",
    y = "Number of Private alleles (Pa)"
  )

plot3

#plot Fis against state
plot4 <- seaspurge %>% 
  ggplot(aes(x = pop_no, y = Fis)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Figure 4: Inbreeding coefficient for each sampled population",
    x = "Population number (pop_no)",
    y = "Inbreeding coefficient (Fis)"
  )

plot4

#Combining plots into one
plot_grid(plot1, plot2, plot3, plot4)

?labs
