--[[ Spieler "Klasse" ]]

--[[ require "source/figure" ]]

player = {}

players = {}
table.insert(players, player)

--[[ Spieler Direction ]]

--[[ Wie weit kann sich der Spieler bewegen ]]
playMoveLimit = 2

playerString = "will"

function player:load()
  
    --[[ Sprite der Spielerfigur ]]
    player.will = love.graphics.newImage("assets/char/tiny Will.png")
    player.helena = love.graphics.newImage("assets/char/tiny Helena.png")


    --[[ Start Position des Spielers ]]
    player.posX = boardArray[1][1][1]
    player.posY = boardArray[1][1][2]

    --[[ print(players[1].posX) ]]

end

function player:update(dt)
    --[[ In welche Richtung guckt die Figur ]]
    playDir = figureDir
end


function player:draw(dt)

    --[[ TODO: Feste Größenwerte müssen durch Variablen ersetzt werden]]
    if playerString == "will" then
        love.graphics.draw(player.will, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 62.5, 62.5 )
    elseif playerString == "helena" then
        love.graphics.draw(player.helena, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 62.5, 62.5 )
    end
end