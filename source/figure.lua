--[[ Hier werden die Figuren beschrieben ]]

require("/source/playboard")

figure = {}

--[[ Parameter ]]

figure.width = absX * 0.05
figure.height = absY * 0.05

figDistX = (tile.width/2)-(figure.width/2)
figDistY = (tile.height/2)-(figure.height/2)

function figure:update(dt)


end

function figure:load()

    figPosX = boardArray[1][1][1]
    figPosY = boardArray[1][1][2]

end


function figure:draw(dt)

    love.graphics.setColor(0.7,0.2,0.4)
    love.graphics.rectangle("fill", figPosX + figDistX, figPosY + figDistY, figure.width, figure.height)
    --[[ love.graphics.rectangle("fill", 100, 100, 100, 100) ]]

end

