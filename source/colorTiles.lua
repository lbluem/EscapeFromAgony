--[[ Visualisierung der Bewegungs Reichweite ]]
--[[ require "source/playboard" ]]
colorTiles = {}

function colorTiles:load()

    --[[ "klaut" sich das Array aus "playboard.lua" ]]
    colorTilesBoard = boardArray

    tileAdjust = tile.width * 1.08


end

function colorTiles:draw(dt)

    --[[ TODO: Folgendes in seperate Funktion ummünzen und
    mit Argument welche Figur ausgewählt ist ausgeführt wird ]]

    if isSelected then
        --[[ welche Figur ist ausgewählt ]]
        if yourTurn then
            --[[ colorTilesBoard wird durchlaufen und identisch 
            zur moveLimit Funktion aus Picker dementsprechend bemalt ]]
            for i = 1,5 do
                for j = 1,4 do
                    if math.abs(colorTilesBoard[i][j][1] - player.posX) <= playMoveLimit*blankX+1 and
                    math.abs(colorTilesBoard[i][j][2] - player.posY) <= playMoveLimit*blankY+1 then
                        --[[ Rundet Abstand ]]
                        yDist = math.floor(math.abs((colorTilesBoard[i][j][2] - player.posY) / blankY)*1+.5)/1
                        xDist = math.floor(math.abs((colorTilesBoard[i][j][1] - player.posX) / blankX)*1+.5)/1
                        if xDist + yDist <= playMoveLimit then
                            if canMove then
                                love.graphics.setColor(0.6,1,0.6,0.3)
                                love.graphics.rectangle("fill", colorTilesBoard[i][j][1],colorTilesBoard[i][j][2], tileAdjust, tileAdjust, 10, 10)
                            end
                            for a, enemy in ipairs(enemies) do
                                if round(enemy.posX,2) == round(colorTilesBoard[i][j][1],2)
                                and round(enemy.posY,2) == round(colorTilesBoard[i][j][2],2) then
                                    love.graphics.setColor(1,0,0,0.6)
                                    love.graphics.rectangle("fill", colorTilesBoard[i][j][1],colorTilesBoard[i][j][2], tileAdjust, tileAdjust, 10, 10)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end