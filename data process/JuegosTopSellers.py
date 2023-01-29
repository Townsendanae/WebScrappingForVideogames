from getInfo import *
import numpy as np
import random as rd
import json

nombreArchivoJson = "totalJuegosTopSellers"
rutaJSON = "./json/"

##Obtener Info
steamTitle, steamPrice ,steamDiscount, steamPicture, steamShop, isStoreSteam = getInfoByShop("Steam","steamGamesSingleplayer")

titles = np.array(steamTitle)
prices = np.array(steamPrice)
discounts = np.array(steamDiscount)
picturesLinks = np.array(steamPicture)
toShops = np.array(steamShop)
shopName = np.array(isStoreSteam)
##Por ser juegos gratis o economicos, se realiza un shuffle y se seleccionan los primeros 20. 
finalRange = titles.size - 1
randomIndex = np.array(rd.sample(range(0, finalRange), 15))

## Titulos seleccionados 
titlesToShow = titles[randomIndex]
pricesToShow = prices[randomIndex]
discountsToShow = discounts[randomIndex]
picturesLinksToShow = picturesLinks[randomIndex]
toShopsToShow = toShops[randomIndex]
shopNameToShow = shopName[randomIndex]

##To dictionary
information = {}
information["tienda"] = ["Steam"]
information["search"] = "Economicos"
results = []

for indexGame in range(len(titlesToShow)):
    dict = {}
    dict["title"] = titlesToShow[indexGame]
    dict["price"] = pricesToShow[indexGame]
    dict["discount"] = discountsToShow[indexGame]
    dict["pictureLink"] = picturesLinksToShow[indexGame]
    dict["linkToShop"] = toShopsToShow[indexGame]
    dict["shopName"] = shopNameToShow[indexGame]
    results.append(dict)

information["result"] = results

##To JSON
with open(rutaJSON+nombreArchivoJson+'.json', 'w') as json_file:
    json.dump(information, json_file)

from toServer import *







