require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html. importando libreria
require 'csv' # escribir y leer csv


link = 'https://www.eneba.com/latam/store/games-under-1?page=1&rangeTo=1&regions[]=global&types[]=game'


results = []

# abrir el link
pagina = URI.open(link)

contenido_parseado = Nokogiri::HTML(pagina.read)
contenedor = contenido_parseado.css('.JZCH_t').css('.pFaGHa')
contenedor.each do |box|
  pictureBox = box.css('._vfaJQ').css('picture').css('img')
  pictureLink = pictureBox.attr("src")
  titleBox = box.css('.tUUnLz')
  title = titleBox.css('.x4MuJo').css('.lirayz').inner_text
  priceBox = box.css('.b3POZC').css('a')
  link = "https://www.eneba.com" + priceBox.attr("href").inner_text
  price = priceBox.css('.DTv7Ag').css('.L5ErLT').inner_text
  price = 'Free to Play' if price == '0.00 €'

  dicTemporary = {}
  dicTemporary[:title] = title.to_s
  dicTemporary[:price] = price.to_s.gsub(",", ".") 
  dicTemporary[:discount] = ""
  dicTemporary[:pictureLink] = pictureLink.to_s
  dicTemporary[:linkToShop] = link.to_s
  dicTemporary[:shopName] = "Eneba"
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

