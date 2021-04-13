--[[ Hello
My Name is Joe
And I work in a button factory!]]

require("source/tile")

playboard = {}
boardArray = {}

for i = 1,5 do
    boardArray[i] = {}
    for j = 1,4 do
        boardArray[i][j] = {}
    end
end


startX = absX * 0.06
startY = absY * 0.10

disX = absX * 0.04
disY = absY * 0.08

blankX = tile.width + disX
blankY = tile.height + disY

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


function getPos(x,y)
    if x <= startX+blankX then
        print("hallo")
        
    end
end