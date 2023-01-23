from getInfo import *
import random as rd
import json

nombreArchivoJson = "steamGamesSP"
rutaJSON = "./json/"

with open ("./archivos/steamGamesSingleplayer.csv", encoding="utf-8") as file:
    file.readline()
    for line in file:
        name,price,imgLink, linkToShop = line.split(",")
        if price != "Free to Play":
            lista = price.split("$")
            print(lista)