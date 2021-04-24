--[[ Spieler "Klasse" ]]

--[[ require("source/figure") ]]

player = {}

--[[ Spieler Direction ]]

playDir = figureDir

playMoveLimit = 2

function player:load()

    playerImage = love.graphics.newImage("assets/char/tiny Will.png")

    --[[ Start Position des Spielers ]]
    playPosX = boardArray[1][1][1]
    playPosY = boardArray[1][1][2]

end


function player:draw(dt)

    love.graphics.draw(playerImage, playPosX + figDistX, playPosY + figDistY, 0, playDir,1, 62.5, 62.5 )
end
