## Plantilla base de scraping en Eneba

def doScrappingEneba(Game)
    
  require 'open-uri' # consultar a la plataforma
  require 'nokogiri' # formatear, parsear a html. importando libreria
  require 'csv' # escribir y leer csv


  ruta = "archivos/"
  rutaJSON = "json/"
  nombreArchivo = "EnebaGeneral"
  busqueda = 'General'

  #Plantilla de acuerdo a link
  link = 'https://www.eneba.com/latam/store'

  dictionary = {}
  dictionary[:tienda] = ["Eneba","https://1000marcas.net/wp-content/uploads/2021/06/Eneba-logo.png"]
  dictionary[:search] = busqueda
  results = []

  pagina = URI.open(link)
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

    
    dicTemporary = {}
    dicTemporary[:title] = title.to_s
    dicTemporary[:price] = price.to_s.gsub(",", ".") 
    dicTemporary[:discount] = ""
    dicTemporary[:pictureLink] = pictureLink.to_s
    dicTemporary[:linkToShop] = link.to_s
    dicTemporary[:shopName] = "Ebena"
    results.push(dicTemporary)
    
    CSV.open(ruta+nombreArchivo+".csv", 'a') do |csv|
      csv << [title.to_s, price.to_s.gsub(",", "."), "", pictureLink.to_s, link.to_s, "Ebena"] 
    end
  end


  dictionary[:results] = results
  require 'json'
  json = dictionary.to_json
  File.write(rutaJSON + nombreArchivo+'.json', json)


end