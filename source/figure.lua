--[[ Hier werden die Figuren beschrieben
    momentan hauptsächlich für den Spieler]]

--[[ TODO: Figuren müssen sich noch dynamisch der Fenster Größe anpassen ]]

--[[ require("/source/playboard") ]]

--[[ Objekterstellung der Figur (momentan noch der Spieler) ]]
figure = {}

--[[ Parameter ]]

figure.width = absX * 0.05
figure.height = absY * 0.05

moveLimit = 2

--[[ Richtungs Variable ]]

figureDir = -1

--[[ Abstand der Figur zum Tile um perfekt in der Mitte zu sein ]]
figDistX = (tile.width/2)--[[ -(figure.width/2) ]]
figDistY = (tile.height/2)--[[ -(figure.height/2) ]]

--[[ function figure:update(dt)
end ]]
--[[ function figure:load()
end ]]
--[[ function figure:draw(dt)
end ]]

