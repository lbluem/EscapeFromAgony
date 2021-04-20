--[[ Hello
My Name is Joe
And I work in a button factory!]]

--[[ Greift auf Inhalte von "tile" zu ]]
require("source/tile")

--[[ Objekterstellung des Spielfeldes ]]
playboard = {}

--[[ 2 Dimensionales Array ]]
boardArray = {}
for i = 1,5 do
    boardArray[i] = {}
    for j = 1,4 do
        boardArray[i][j] = {}
    end
end

--[[ Startpunkt der Felder ]]
startX = absX * 0.06
startY = absY * 0.10

--[[ Abstand zwischen den Felder ]]
disX = absX * 0.04
disY = absY * 0.08

--[[ Abstand der linken oberen Ecken eines Feldes bis zur nächsten ]]
blankX = tile.width + disX
blankY = tile.height + disY

--[[ BoardArray wird einmalig am Anfang mit exakten Koordinaten gefüllt 
    (könnte zu Problemen führen, wenn während der Spielzeit die Fenstergröße angepasst wird) ]]
function playboard:load()
   --[[  love.graphics.setColor(1,1,1) ]]
    for i = 0, 4 do
        for j = 0, 3 do 
            --[[ love.graphics.rectangle("fill", startX + (i * (disX + tile.width)), startY + (j * (disY + tile.height)), tile.width, tile.height) ]]
            boardArray[i+1][j+1] = {startX + (i * (disX + tile.width)), startY + (j * (disY + tile.height))}
            print(boardArray[i+1][j+1][1],boardArray[i+1][j+1][2])
        end
    end
end

--[[ Evtl. später durch feste Hintergrundbilder ersetzt ]]
function playboard:draw(dt)

    love.graphics.setColor(1,1,1,0.3)

    for x = 1,5 do
        for y = 1,4 do
            love.graphics.rectangle("fill", boardArray[x][y][1],boardArray[x][y][2], tile.width, tile.height)
        end
    end
end


--[[ Funktion um Array Position in Pixel Position umzuwandeln ]]
function getXPos(x,y)
    return boardArray[x][y][1]
end

function getYPos(x,y)
    return boardArray[x][y][2]
end
