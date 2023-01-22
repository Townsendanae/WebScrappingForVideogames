require 'nokogiri'
require 'open-uri'
require 'csv'

ruta = 'archivos/'
nombreArchivo = 'GOGJuegosGratis.csv'

url = 'https://www.gog.com/en/games?priceRange=0,0'

pagina = URI.open(url)
datos = pagina.read
page = Nokogiri.HTML(datos)

CSV.open(ruta + nombreArchivo, 'w') { |csv| csv << %w[Name Price Discount Image Link] }

page
  .css('.product-tile.product-tile--grid')
  .each do |game|
  link = game.attr('href')
  name = game.css('.product-tile__title').attr('title')
  price =
    game
    .css('.product-tile__footer')
    .css('.product-tile__price-info')
    .css('product-price')
    .css('price-value')
    .css('.final-value')
    .text
  discount =
    game
    .css('.product-tile__footer')
    .css('.product-tile__price-info')
    .css('product-price')
    .css('price-discount')
    .text
  discount = '0%' if discount == ''
  price = '$0.00' if price == ''
  image = game
          .css('.product-tile__image-wrapper')
          .css('picture')
          .css('source')
          .attr('srcset').to_s.split(',')[0]
  if image == '' || image == nil
    image = 'https://media.kasperskydaily.com/wp-content/uploads/sites/92/2020/02/17105257/game-ratings-featured.jpg'
  end
  CSV.open(ruta + nombreArchivo, 'a') { |csv| csv << [name, price, discount, image, link] }
end
