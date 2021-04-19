--[[ Gegner "Klasse" (ist nicht wirklich eine Klasse) ]]
require("source/figure")

--[[ Objekterstellung des Gegners ]]
enemy = {}

--[[ Parameter ]]

enemy.width = absX * 0.05
enemy.height = absY * 0.05

eneDistX = (tile.width/2)-(enemy.width/2)
eneDistY = (tile.height/2)-(enemy.height/2)

function enemy:load()

    --[[ Start Position im Array ]]
    enePosX = boardArray[4][3][1]
    enePosY = boardArray[4][3][2]

end


function enemy:update(dt)
end

function enemy:draw(dt)

    --[[ Gegner wird "gemalt" ]]
    love.graphics.setColor(0.1,0.5,0.3)
    love.graphics.rectangle("fill", enePosX + eneDistX, enePosY + eneDistY, enemy.width, enemy.height)

end