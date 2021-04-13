Hello
My Name is Joe
And I work in a button factory!

playboard = {}

absX = love.graphics.getWidth() 
absY = love.graphics.getHeight()

startX = absX * 0.06
StartY = absY * 0.08

tileX = absX * 0.144
tileY = absY * 0.16

function playboard:draw (dt)
    love.graphics.setColor(1,1,1)
    for i 1, 5 do
        for j 1, 4 do 
            love.graphics.rectangle("fill", startX, startY, tileX, tileY)
        end
    end
end