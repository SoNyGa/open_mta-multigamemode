Lobby = Gamemode{nil, "Lobby", "This is the Lobby", "StiviK", 0, 9999, 1, {0, 0, 0, 21}, {0, 0, 3, "cylinder", 1}} -- Register a new Gamemode
--Mapmanager:loadMap(Lobby, "mytestgamemode/testa.map")

function Lobby:onPlayerJoin (player)
	player:sendMessage(("Willkommen %s"):format(getPlayerName(player)), 255, 0, 0, true)
end

addEventHandler("onPlayerGamemodeJoin", root, function ()
	if (Lobby:isPlayerInGamemode(source)) then
		Lobby:onPlayerJoin(source)
	end
end)