from getInfo import *
import numpy as np
import random as rd
import json

#JuegosEconomicosEneba, juegosGratisGOG 
nombreArchivoJson = "GameSearch"
rutaJSON = "./json/"
tiendas = ["Eneba"]

#SolicitarDatos
juego = "minecraft"

##Obtener Info
enebaTitle, enebaPrice ,enebaDiscount, enebaPicture, enebaShop, isStoreEneba = getInfoByShop("Eneba","Eneba_"+juego)
# gogTitle, gogPrice ,gogDiscount, gogPicture, gogShop, isStoreGog = getInfoByShop("GOG","GOG_"+juego)
# steamTitle, steamPrice ,steamDiscount, steamPicture, steamShop, steamStoreGog = steamInfoByShop("Steam","Steam_"+juego)

titles = np.array(enebaTitle)
prices = np.array(enebaPrice )
discounts = np.array(enebaDiscount)
picturesLinks = np.array(enebaPicture)
toShops = np.array(enebaShop)
shopName = np.array(isStoreEneba)


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
information["tienda"] = tiendas
information["search"] = juego
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
with open(rutaJSON+nombreArchivoJson+"_"+juego+'.json', 'w') as json_file:
    json.dump(information, json_file)







