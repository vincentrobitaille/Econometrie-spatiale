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
nb2mat(x)

rom_regions <- c("R011", "RO12", "RO21", "RO22", "RO31", "RO32", "RO41", "RO42")
rom_regions <- 1:8
nbrom <- read.gal("romania.GAL", region.id = rom_regions)
# names(nbrom) <- c("R011", "RO12", "RO21", "RO22", "RO31", "RO32", "RO41", "RO42")

wrom <- nbrom |> nb2listw(style = "B")

wrom2 <- nbrom |> nb2listw(style = "W")

m <- wrom |> listw2mat()

m |> as.numeric() |> mean()

mr <- read.csv("romania_inf_mor_rate.csv", header = FALSE)

lagged_var <- lag.listw(wrom, mr$V2)


# EXO 2.4
# 1: Wales
# 2: Scotland
# 3: North Ireland
# 4: North of England
# 5: North West of England
# 6: Workshire & Humberside
# 7: East Midlands
# 8: West Midlands
# 9: East Anglia
# 10: Greater London
# 11: South East England
# 12: South West England



















