--[[ Das Objekt (<- in Lua "Table") "tile" also ein Feld wird erzeugt ]]
tile = {}

--[[ Variablen um Relation zur absoluten Größe des Fensters herzustellen]]
absX = love.graphics.getWidth() 
absY = love.graphics.getHeight()

--[[ Maße eines Tiles (Feldes) in Relation zur Fenster Größe ]]

--[[ tile.width = absX * 0.144 ]]
tile.height = absY * 0.14
tile.width = tile.height

--[[ Schach ähnliche Felder Beschreibung (zur Positionsfindung)
Überflüssig?? ]]
tile.quadX = 1
tile.quadY = 1