require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html. importando libreria
require 'csv' # escribir y leer csv

#20 primero recomendados ENEBA.

ruta = "archivos/"
rutaJSON = "json/"
nombreArchivo = "EnebaRecomendados"
busqueda = "Recomendados"

link = 'https://www.eneba.com/latam/store/all?page=1&sortBy=POPULARITY_DESC'

dictionary = {}
dictionary[:search] = busqueda
results = []

# abrir el link
pagina = URI.open(link)

CSV.open(ruta+nombreArchivo + ".csv", 'w') do |csv|
    csv << ["title", "price", "picture link", "link to shop"] 
  end

contenido_parseado = Nokogiri::HTML(pagina.read)
contenedor = contenido_parseado.css('.JZCH_t').css('.pFaGHa')
contenedor.each do |box|
  pictureBox = box.css('._vfaJQ').css('picture').css('img')
  pictureLink = pictureBox.attr("src")
  titleBox = box.css('.tUUnLz')
  title = titleBox.css('.x4MuJo').css('.lirayz').inner_text
  priceBox = box.css('.b3POZC').css('a')
  link = "https://www.eneba.com/" + priceBox.attr("href").inner_text
  price = priceBox.css('.DTv7Ag').css('.L5ErLT').inner_text

  dicTemporary = {}

  dicTemporary[:title] = title.to_s
  dicTemporary[:price] = price.to_s 
  dicTemporary[:pictureLink] = pictureLink.to_s
  dicTemporary[:linkToShop] = link.to_s

  results.push(dicTemporary)
  
  CSV.open(ruta+nombreArchivo + ".csv", 'a') do |csv|
    csv << [title.to_s, price.to_s, pictureLink.to_s,link.to_s] 
  end
end


dictionary[:results] = results

require 'json'
json = dictionary.to_json
File.write(rutaJSON + nombreArchivo+'.json', json)