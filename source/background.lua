--[[ Hintergründe ]]

background = {}

--[[ absX = love.graphics.getWidth() 
absY = love.graphics.getHeight() ]]

--[[ TODO: Hintergrund ist noch nicht Variable ]]

function background:load()
    caveBG = love.graphics.newImage("assets/backgrounds/cave bg.jpg")
    stonyBG = love.graphics.newImage("assets/backgrounds/Stony Wall3.png")
    sandyBG = love.graphics.newImage("assets/backgrounds/sand_template_0.jpg")
end


function background:draw(dt)
    love.graphics.setColor(1,1,1)
    if levelState == 1 then
        love.graphics.draw(stonyBG, 0,0,0,2.5,1.7)
    elseif levelState == 2 then
        love.graphics.draw(caveBG, 0,0,0,2.5,1.7)
    elseif levelState == 3 then
        love.graphics.draw(sandyBG, 0,0,0,2.5,1.7)
    end
end