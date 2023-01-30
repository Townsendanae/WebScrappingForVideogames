require 'open-uri'
require 'nokogiri'
require 'csv'

results = []

link = 'https://store.steampowered.com/search/?filter=topsellers'
pagina = URI.open(link)
datos = pagina.read
parsed_content = Nokogiri::HTML(datos)
contenedor = parsed_content.css('body div div').css('.page_content').css('.leftcol').css('.search_results').css('a')

contenedor.css('.search_result_row').each do |game|
    
        img = game.css('.col.search_capsule').css('img').attr('src').inner_text
        name = game.css('.responsive_search_name_combined').css('.col.search_name.ellipsis').css('.title').inner_text.strip
        priceBox = game.css('.responsive_search_name_combined').css('.col.search_price').inner_text.strip.split("$")[1...]
        linkToShop = game.attr('href')
        
        if priceBox == nil || priceBox.size == 0
            price = 'not available'      
        elsif priceBox.size > 1 
            price = priceBox[0]
            discount =  "%" + (((priceBox[1].to_f - price.to_f) / price.to_f * 100)*-1).round(2).to_s
        else 
            price = priceBox[0]
        end      
        discount = "0%" if (discount == "" || discount == nil )
        dicTemporary = {}
        dicTemporary[:title] = name
        dicTemporary[:price] = price
        dicTemporary[:discount] = discount
        dicTemporary[:pictureLink] = img
        dicTemporary[:linkToShop] = linkToShop
        dicTemporary[:shopName] = "Steam"
        results.push(dicTemporary)
end

   
#Colocar en la base de datos
require 'json'
serverFile = File.read('./backend/db.json')
data_hash = JSON.parse(serverFile)
arreglo_DBresult = data_hash['totalJuegos']['result'].concat(results)
set = Set.new(arreglo_DBresult.uniq)
data_hash['totalJuegos']['result'] = set.to_a.uniq


data_json = JSON.generate(data_hash)
File.open('././backend/db.json', 'w') do |f|
  f.write(data_json)
end