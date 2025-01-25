library(spdep)
library(tidyverse)

# Crée une liste des voisins
Wnb <- cell2nb(3, 3)
Wnb

# Transforme la liste des voisins en matrice W
W <- nb2listw(Wnb)
W$weights

Wmat <- nb2mat(Wnb)

# EXO 2.1

W21 <- matrix(0, nrow = 8, ncol = 8)
colnames(W21) <- c("RO11", "RO12", "RO21", "RO22", 
                   "RO31", "RO32", "RO41", "RO42")
row.names(W21) <- c("RO11", "RO12", "RO21", "RO22", 
                   "RO31", "RO32", "RO41", "RO42")
W21[1,] <- c(0, 1, 1, 0, 0, 0, 0, 1)
W21[2,] <- c(1, 0, 1, 1, 1, 0, 1, 1)
W21[3,] <- c(1, 1, 0, 1, 0, 0, 0, 0)
W21[4,] <- c(0, 1, 1, 0, 1, 0, 0, 0)
W21[5,] <- c(0, 1, 0, 1, 0, 1, 1, 0)
W21[6,] <- c(0, 0, 0, 0, 1, 0, 0, 0)
W21[7,] <- c(0, 1, 0, 0, 1, 0, 0, 1)
W21[8,] <- c(1, 1, 0, 0, 0, 0, 1, 0)
x <- mat2listw(W21, style = "W")


rom_regions <- c("R011", "RO12", "RO21", "RO22", "RO31", "RO32", "RO41", "RO42")
rom_regions <- 1:8
nbrom <- read.gal("romania.GAL", region.id = rom_regions)
# names(nbrom) <- c("R011", "RO12", "RO21", "RO22", "RO31", "RO32", "RO41", "RO42")

wrom <- nbrom |> nb2listw(style = "B")

wrom2 <- nbrom |> nb2listw(style = "W")

m <- wrom |> listw2mat()

m |> as.numeric() |> mean()

mr <- read.csv("romania_inf_mor_rate.csv", header = FALSE)

lagged_var <- lag.listw(wrom2, mr$V2)


# EXO 2.4
# 1: Wales
# 2: Scotland
# 3: North Ireland
# 4: North East of England
# 5: North West of England
# 6: Yorkshire & Humberside
# 7: East Midlands
# 8: West Midlands
# 9: East Anglia (East of England)
# 10: Greater London
# 11: South East England
# 12: South West England

ukgal <- read.gal("UK.GAL", region.id = 1:12)

ukl <- ukgal |> nb2listw(style = "B")
ukl |> listw2mat()

# Exo 2.5

ukdat <- read.csv("data1.csv", dec = ",")

laguk <- ukgal |> nb2listw(style = "W") |> lag.listw(ukdat$GVA)
names(laguk) <- c("Wales", "Scotland", "North Ireland", "North East of England",
                     "North West of England", "Yorkshire Humberside",
                     "East Midlands", "West Midlands", "East Anglia",
                     "Greater London", "South East England", "South West England")
laguk


# Exo 2.9
#https://public.opendatasoft.com/explore/dataset/us-state-boundaries/table/?location=3,20.11268,7.82227&basemap=jawg.light&dataChart=eyJxdWVyaWVzIjpbeyJjb25maWciOnsiZGF0YXNldCI6InVzLXN0YXRlLWJvdW5kYXJpZXMiLCJvcHRpb25zIjp7fX0sImNoYXJ0cyI6W3siYWxpZ25Nb250aCI6dHJ1ZSwidHlwZSI6ImNvbHVtbiIsImZ1bmMiOiJBVkciLCJ5QXhpcyI6ImdpZCIsInNjaWVudGlmaWNEaXNwbGF5Ijp0cnVlLCJjb2xvciI6IiNGRjUxNUEifV0sInhBeGlzIjoibmFtZSIsIm1heHBvaW50cyI6NTAsInNvcnQiOiIifV0sInRpbWVzY2FsZSI6IiIsImRpc3BsYXlMZWdlbmQiOnRydWUsImFsaWduTW9udGgiOnRydWV9

library(sf)
library(sp)

us <- read_sf("s_05mr24/s_05mr24.shp") |> 
  filter(!(NAME %in% c("Guam",
                       "Palau",
                       "Marshall Islands",
                       "Northern Mariana Islands",
                       "Fed States of Micronesia",
                       "Puerto Rico",
                       "Hawaii",
                       "Alaska",
                       "Virgin Islands",
                       "American Samoa")))

us <- read_sf("us-state-boundaries/us-state-boundaries.shp") |> 
  filter(!(name %in% c("Guam",
                       "Palau",
                       "Marshall Islands",
                       "Northern Mariana Islands",
                       "Fed States of Micronesia",
                       "Puerto Rico",
                       "Commonwealth of the Northern Mariana Islands",
                       "Hawaii",
                       "Alaska",
                       "United States Virgin Islands",
                       "American Samoa")))

names(us)
plot(us)

contus <- us |> poly2nb(queen = TRUE)




