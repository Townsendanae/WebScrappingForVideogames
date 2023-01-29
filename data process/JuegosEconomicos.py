from getInfo import *
import numpy as np
import random as rd
import json

#JuegosEconomicosEneba, juegosGratisGOG 
nombreArchivoJson = "totalJuegosEconomicos"
rutaJSON = "./json/"

##Obtener Info
enebaTitle, enebaPrice ,enebaDiscount, enebaPicture, enebaShop, isStoreEneba = getInfoByShop("Eneba","EnebaEconomicos")
gogTitle, gogPrice ,gogDiscount, gogPicture, gogShop, isStoreGog = getInfoByShop("GOG","GOGJuegosGratis")
steamTitle, steamPrice ,steamDiscount, steamPicture, steamShop, isStoreSteam = getInfoByShop("Steam","steamGamesTopSellers")

titles = np.array(enebaTitle + gogTitle + steamTitle)
prices = np.array(enebaPrice + gogPrice + steamPrice)
discounts = np.array(enebaDiscount + gogDiscount + steamDiscount)
picturesLinks = np.array(enebaPicture + gogPicture + steamPicture)
toShops = np.array(enebaShop + gogShop + steamShop)
shopName = np.array(isStoreEneba + isStoreGog + isStoreSteam)
print(titles.size, prices.size, discounts.size, picturesLinks.size, toShops.size, shopName.size)
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
information["tienda"] = ["Eneba", "GOG", "Steam"]
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




