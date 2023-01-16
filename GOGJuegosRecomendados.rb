require "nokogiri"
require "open-uri"
require "csv"

ruta = "archivos/"
nombreArchivo = "GOGJuegosRecomendados.csv"

url = "https://www.gog.com/en/games"

pagina = URI.open(url)
datos = pagina.read
page = Nokogiri.HTML(datos)

CSV.open(ruta + nombreArchivo, "w") { |csv| csv << %w[Name Price Discount Link] }

page
    .css(".product-tile.product-tile--grid")
    .each do |game|
        link = game.attr("href")
        name = game.css(".product-tile__title").attr("title")
        price =
            game
                .css(".product-tile__footer")
                .css(".product-tile__price-info")
                .css("product-price")
                .css("price-value")
                .css(".final-value")
                .text
        discount =
            game
                .css(".product-tile__footer")
                .css(".product-tile__price-info")
                .css("product-price")
                .css("price-discount")
                .text
        discount = "0%" if (discount == "")
        CSV.open(ruta + nombreArchivo, "a") { |csv| csv << [name, price, discount, link] }
    end
