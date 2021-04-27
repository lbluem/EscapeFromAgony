--[[ Visualisierung der Bewegungs Reichweite ]]
--[[ require "source/playboard" ]]
colorTiles = {}

function colorTiles:load()

    colorTilesBoard = boardArray

end

function colorTiles:draw(dt)

    if isSelected then
        --[[ welche Figur ist ausgewählt ]]
        --[[ colorTilesBoard wird durchlaufen und identisch 
        zur moveLimit Funktion aus Picker dementsprechend bemalt ]]
        if yourTurn then
            for i = 1,5 do
                for j = 1,4 do
                    if math.abs(colorTilesBoard[i][j][1] - playPosX) <= playMoveLimit*blankX+1 and
                    math.abs(colorTilesBoard[i][j][2] - playPosY) <= playMoveLimit*blankY+1 then
                        --[[ Rundet Abstand ]]
                        yDist = math.floor(math.abs((colorTilesBoard[i][j][2] - playPosY) / blankY)*1+.5)/1
                        xDist = math.floor(math.abs((colorTilesBoard[i][j][1] - playPosX) / blankX)*1+.5)/1
                        if xDist + yDist <= playMoveLimit then
                            love.graphics.setColor(0,1,0,0.2)
                            love.graphics.rectangle("fill", colorTilesBoard[i][j][1],colorTilesBoard[i][j][2], tile.width, tile.height)
                        end
                    end
                end
            end
        else
            for i = 1,5 do
                for j = 1,4 do
                    if math.abs(colorTilesBoard[i][j][1] - enePosX) <= playMoveLimit*blankX+1 and
                    math.abs(colorTilesBoard[i][j][2] - enePosY) <= playMoveLimit*blankY+1 then
                        --[[ Rundet Abstand ]]
                        yDist = math.floor(math.abs((colorTilesBoard[i][j][2] - enePosY) / blankY)*1+.5)/1
                        xDist = math.floor(math.abs((colorTilesBoard[i][j][1] - enePosX) / blankX)*1+.5)/1
                        if xDist + yDist <= playMoveLimit then
                            love.graphics.setColor(1,0,0,0.2)
                            love.graphics.rectangle("fill", colorTilesBoard[i][j][1],colorTilesBoard[i][j][2], tile.width, tile.height)
                        end
                    end
                end
            end
        end
    end
    --[[ love.graphics.rectangle("fill", colorTilesBoard[1][2][1],colorTilesBoard[1][2][2], tile.width, tile.height) ]]

end