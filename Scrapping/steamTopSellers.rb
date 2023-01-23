require 'open-uri'
require 'nokogiri'
require 'csv'

link = 'https://store.steampowered.com/search/?filter=topsellers'
pagina = URI.open(link)
datos = pagina.read
parsed_content = Nokogiri::HTML(datos)
contenedor = parsed_content.css('body div div').css('.page_content').css('.leftcol').css('.search_results').css('a')
CSV.open('./archivos/steamGamesTopSellers.csv', 'wb') do |csv|
    csv << %w[name price imgLink linkToShop]
  end
contenedor.css('.search_result_row').each do |game|
    CSV.open('./archivos/steamGamesTopSellers.csv', 'a') do |csv|
        img = game.css('.col.search_capsule').css('img').attr('src')
        name = game.css('.responsive_search_name_combined').css('.col.search_name.ellipsis').css('.title').inner_text.strip
        price = game.css('.responsive_search_name_combined').css('.col.search_price').inner_text.strip
        linkToShop = game.attr('href')
        if !price.empty? && price == 'Free to Play'
            csv << [name, price, img, linkToShop]
        end
    end
end