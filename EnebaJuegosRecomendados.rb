require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html. importando libreria
require 'csv' # escribir y leer csv


ruta = "archivos/"
nombreArchivo = "EnebaRecomendados.csv"

#20 primero recomendados ENEBA.

linkRecomendacionesEneba = 'https://www.eneba.com/latam/store/all?page=1&sortBy=POPULARITY_DESC'

# abrir el link
pagina = URI.open(linkRecomendacionesEneba)

CSV.open(ruta+nombreArchivo, 'w') do |csv|
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
  
  CSV.open(ruta+nombreArchivo, 'a') do |csv|
    csv << [title.to_s, price.to_s, pictureLink.to_s,link.to_s] 
  end
end
