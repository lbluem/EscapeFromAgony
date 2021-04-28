--[[ Spieler "Klasse" ]]

--[[ require "source/figure" ]]

player = {}

--[[ Spieler Direction ]]

--[[ Wie weit kann sich der Spieler bewegen ]]
playMoveLimit = 2

function player:load()

    --[[ Sprite der Spielerfigur ]]
    playerImage = love.graphics.newImage("assets/char/tiny Will.png")

    --[[ Start Position des Spielers ]]
    playPosX = boardArray[1][1][1]
    playPosY = boardArray[1][1][2]

end

function player:update(dt)
    --[[ In welche Richtung guckt die Figur ]]
    playDir = figureDir
end


function player:draw(dt)

    --[[ TODO: Feste Größenwerte müssen durch Variablen ersetzt werden]]
    love.graphics.draw(playerImage, playPosX + figDistX, playPosY + figDistY, 0, playDir,1, 62.5, 62.5 )
end
