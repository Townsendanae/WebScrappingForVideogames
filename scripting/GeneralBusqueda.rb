require_relative "Scrapping/SearchByStore/EnebaJuegosBusqueda"
require_relative "Scrapping/SearchByStore/GOGJuegosBusqueda"
require_relative "Scrapping/SearchByStore/SteamJuegosBusqueda"

game = ARGV[0]

gogSearchByGame(game)
SteamSearchByGame(game)
enebaSearchByGame(game)