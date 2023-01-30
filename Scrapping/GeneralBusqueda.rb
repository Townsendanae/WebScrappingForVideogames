require_relative "SearchByStore/EnebaJuegosBusqueda"
require_relative "SearchByStore/GOGJuegosBusqueda"
require_relative "SearchByStore/SteamJuegosBusqueda"

game = "a"

gogSearchByGame(game)
SteamSearchByGame(game)
enebaSearchByGame(game)