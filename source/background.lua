--[[ Hintergründe ]]

background = {}

--[[ absX = love.graphics.getWidth() 
absY = love.graphics.getHeight() ]]

--[[ TODO: Hintergrund ist noch nicht Variable ]]

function background:load()
    stonyBG = love.graphics.newImage("assets/backgrounds/Stony Wall.jpg")
    forestBG = love.graphics.newImage("assets/backgrounds/forest.png")
    sandyBG = love.graphics.newImage("assets/backgrounds/sand_template_0.jpg")
end


function background:draw(dt)
    love.graphics.setColor(1,1,1)
    if dialogueState == 1 then
        love.graphics.draw(stonyBG, 0,0,0,0.67,0.67)
    elseif dialogueState == 2 then
        love.graphics.draw(forestBG, 0,0,0,1.4,1.4)
    elseif dialogueState >= 3 then
        love.graphics.draw(sandyBG, 0,0,0,2.5,1.7)
    end
end