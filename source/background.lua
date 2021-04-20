--[[ Hintergründe ]]

background = {}

--[[ absX = love.graphics.getWidth() 
absY = love.graphics.getHeight() ]]

function background:load()
    caveBG = love.graphics.newImage("assets/backgrounds/cave bg.jpg")
end


function background:draw(dt)
    love.graphics.draw(caveBG, 0,0,0,1.1,1.1)
end