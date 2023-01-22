
def getInfoByShop(ShopName, fileName):
    lstTitle = []
    lstPrice = []
    lstDiscount = []
    lstPictureLink = []
    lstLinkToShop = []
    lstStore = []

    if ShopName == "Eneba":
        with open ("./archivos/"+fileName+".csv", encoding="utf-8") as file:
            file.readline()
            for line in file: 
                title,price,discount,pictureLink,linkToShop,nameStore = line.split(",")
                lstTitle.append(title.strip())
                lstPrice.append(price.strip("€").strip().replace(u'\xa0', u''))
                lstDiscount.append(discount.strip())
                lstPictureLink.append(pictureLink.strip())
                lstLinkToShop.append(linkToShop.strip())
                lstStore.append(nameStore.strip())
    if ShopName == "GOG":
        with open ("./archivos/"+fileName+".csv", encoding="utf-8") as file:
            file.readline()
            for line in file: 
                name,price,discount,picture,link = line.split(",")
                lstTitle.append(name.strip())
                lstPrice.append(price.strip("$").strip())
                lstDiscount.append(discount.strip("%").strip())
                lstPictureLink.append(picture.strip())
                lstLinkToShop.append(link.strip())
                lstStore.append("Gog")
    return lstTitle, lstPrice ,lstDiscount, lstPictureLink, lstLinkToShop, lstStore
