def gogSearchByGame(game)
    require 'nokogiri'
    require 'open-uri'
    require 'csv'


    url = 'https://www.gog.com/en/games?query=' + game

    pagina = URI.open(url)
    datos = pagina.read
    page = Nokogiri.HTML(datos)


    results = []


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
        price = 'Free to Play' if price == ''
        image = game
                .css('.product-tile__image-wrapper')
                .css('picture')
                .css('source')
                .attr('srcset').to_s.split(',')[0]
        if image == '' || image == nil
            image = 'https://media.kasperskydaily.com/wp-content/uploads/sites/92/2020/02/17105257/game-ratings-featured.jpg'
        end


        dicTemporary = {}
        dicTemporary[:title] = name.to_s
        dicTemporary[:price] = price
        dicTemporary[:discount] = discount
        dicTemporary[:pictureLink] = image
        dicTemporary[:linkToShop] = link
        dicTemporary[:shopName] = "Gog"
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
    File.open('./backend/db.json', 'w') do |f|
    f.write(data_json)
    end

end