--[[ Gegner "Klasse" (ist nicht wirklich eine Klasse) ]]
--[[ require "source/figure" ]]

--[[ Objekterstellung des Gegners ]]
enemy = {}

enemies = {}

--[[ Parameter ]]

enemy.width = figure.width
enemy.height = figure.height

eneDistX = (tile.width/2)--[[ -(enemy.width/2) ]]
eneDistY = (tile.height/2)--[[ -(enemy.height/2) ]]

function addEnemy(type,x,y)

    enemy[type] = {}
    if type == 1 then
        enemy[type].img = love.graphics.newImage("assets/char/tiny Wache 1.png")
    elseif type == 2 then
        enemy[type].img = love.graphics.newImage("assets/char/tiny Wache 1.png")
    elseif type == 3 then
        enemy[type].img = love.graphics.newImage("assets/char/tiny Wache 1.png")
    end
    enemy[type].posX = boardArray[x][y][1]
    enemy[type].posY = boardArray[x][y][2]
    table.insert(enemies,enemy)
end


function enemy:load()

--[[     enemy.wache1 = love.graphics.newImage("assets/char/tiny Wache 1.png")
    enemy.wache2 = love.graphics.newImage("assets/char/tiny Wache 2.png") ]]
    --[[ Start Position im Array ]]
--[[     enemy.posX = boardArray[4][3][1]
    enemy.posY = boardArray[4][3][2] ]]
    addEnemy(1,4,4)
    addEnemy(2,2,3)
    --[[ print(enemies[2].posX) ]]
end


function enemy:update(dt)
end

function enemy:draw(dt)
    --[[ Gegner wird "gemalt" ]]
    love.graphics.setColor(1,1,1,1)
    for a, enemy in ipairs(enemies) do
        love.graphics.draw(enemy[a].img, enemy[a].posX + eneDistX, enemy[a].posY + eneDistY, 0, -1, 1, 62.5, 62.5)
    end
end




--[[ function enemy:create(type, x,y)
    self.__index = self
    
    return setmetatable({
        img = love.graphics.newImage("assets/char/tiny Wache 1.png"),
        posX = boardArray[x][y][1],
        posY = boardArray[x][y][2]
    }, self)
    
end

return enemy ]]