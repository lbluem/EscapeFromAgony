--[[ Hier werden die Figuren beschrieben
    momentan hauptsächlich für den Spieler ]]

require("/source/playboard")

--[[ Objekterstellung der Figur (momentan noch der Spieler) ]]
figure = {}

--[[ Parameter ]]

figure.width = absX * 0.05
figure.height = absY * 0.05

--[[ Richtungs Variable ]]

figureDir = -1

--[[ Abstand der Figur zum Tile um perfekt in der Mitte zu sein ]]
figDistX = (tile.width/2)--[[ -(figure.width/2) ]]
figDistY = (tile.height/2)--[[ -(figure.height/2) ]]

function figure:update(dt)
end


function figure:load()

    playerImage = love.graphics.newImage("assets/char/tiny Will.png")

    --[[ Start Position der Spiele Figur im Array ]]
    figPosX = boardArray[1][1][1]
    figPosY = boardArray[1][1][2]

end


function figure:draw(dt)

    --[[ Figur wird "gemalt" ]]
    --[[ love.graphics.setColor(0.7,0.2,0.4) ]]
    --[[ love.graphics.rectangle("fill", figPosX + figDistX, figPosY + figDistY, figure.width, figure.height) ]]
    love.graphics.draw(playerImage, figPosX + figDistX, figPosY + figDistY, 0, figureDir,1, 62.5, 62.5 )
    --[[ love.graphics.rectangle("fill", 100, 100, 100, 100) ]]

end

