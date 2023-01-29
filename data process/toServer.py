import os
import json

dir = './json'
contenido = os.listdir(dir)
dic = {}

for ficheroName in contenido:
    with open(dir + "/"+ficheroName) as file:
        dic[ficheroName] = json.loads(file.read())

with open("./backend/db.json", "w") as serverFile:
    json.dump(dic, serverFile)


        
