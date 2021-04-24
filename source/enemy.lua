--[[ Gegner "Klasse" (ist nicht wirklich eine Klasse) ]]
--[[ require("source/figure") ]]

--[[ Objekterstellung des Gegners ]]
enemy = {}

--[[ Parameter ]]

enemy.width = figure.width
enemy.height = figure.height

eneDistX = (tile.width/2)--[[ -(enemy.width/2) ]]
eneDistY = (tile.height/2)--[[ -(enemy.height/2) ]]

function enemy:load()

    eneImage = love.graphics.newImage("assets/char/tiny Wache 1.png")
    --[[ Start Position im Array ]]
    enePosX = boardArray[4][3][1]
    enePosY = boardArray[4][3][2]

end


function enemy:update(dt)
end

function enemy:draw(dt)

    --[[ Gegner wird "gemalt" ]]
    --[[ love.graphics.setColor(0.1,0.5,0.3) ]]
    --[[ love.graphics.rectangle("fill", enePosX + eneDistX, enePosY + eneDistY, enemy.width, enemy.height) ]]
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(eneImage, enePosX + eneDistX, enePosY + eneDistY, 0, -1, 1, 62.5, 62.5)

end