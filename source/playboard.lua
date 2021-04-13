--[[ Hello
My Name is Joe
And I work in a button factory!]]

playboard = {}

absX = love.graphics.getWidth() 
absY = love.graphics.getHeight()

startX = absX * 0.06
startY = absY * 0.10

tileX = absX * 0.144
tileY = absY * 0.14

disX = absX * 0.04
disY = absY * 0.08

blankX = tileX + disX
blankY = tileY + disY

function playboard:draw (dt)
    love.graphics.setColor(1,1,1)
    for i = 0, 4 do
        for j = 0, 3 do 
            love.graphics.rectangle("fill", startX + (i * (disX + tileX)), startY + (j * (disY + tileY)), tileX, tileY)
        end
    end
end


function getPos(x,y)
    if x <= startX+blankX then

        return 1
    end
end