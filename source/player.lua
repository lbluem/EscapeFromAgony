--[[ Spieler "Klasse" ]]

--[[ require "source/figure" ]]

player = {}

players = {}


--[[ Spieler Direction ]]

--[[ Wie weit kann sich der Spieler bewegen ]]
playMoveLimit = 2

playerString = "will"

--[[ player.lp = 3 ]]

playerOnBoard = 1

function player:load()
  
    will = {
        image = love.graphics.newImage("assets/char/Will/tiny Will.png"),
        image2 = love.graphics.newImage("assets/char/Will/tiny Will b1.png"),
        image3 = love.graphics.newImage("assets/char/Will/tiny Will b2.png"),
        name = "will",
        hp = 3,
        aRange = 1,
        mRange = 2,
        combo = 1
    }
    helena = {
        image = love.graphics.newImage("assets/char/Helena/tiny Helena wp.png"),
        image2 = love.graphics.newImage("assets/char/Helena/tiny Helena b1.png"),
        image3 = love.graphics.newImage("assets/char/Helena/tiny Helena b2.png"),
        name = "helena",
        hp = 3,
        aRange = 2,
        mRange = 2,
        combo = 0
    }
    godfired = {
        image = love.graphics.newImage("assets/char/Helena/tiny Helena.png"),
        name = "godfired",
        hp = 6,
        aRange = 1,
        mRange = 1,
        combo = 0
    }


    --[[ Start Position des Spielers ]]
    player.posX = boardArray[1][1][1]
    player.posY = boardArray[1][1][2]

    table.insert(players, will)
    table.insert(players, helena)

    --[[ for i, player in ipairs(players) do
        players[i].lp = 3
    end
    print(players[1].lp) ]]
    print(players[1].name) 
end

function player:update(dt)
    --[[ In welche Richtung guckt die Figur ]]
    playDir = figureDir

    for i, player in ipairs(players) do
        if players[i].name == playerString then
            playerOnBoard = i
        end
    end
end


function player:draw(dt)

    --[[ TODO: Feste Größenwerte müssen durch Variablen ersetzt werden]]
    if playerString == "will" then
        if players[playerOnBoard].hp == 3 then
            love.graphics.draw(players[playerOnBoard].image, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 70, 90 )
        elseif players[playerOnBoard].hp == 2 then
            love.graphics.draw(players[playerOnBoard].image2, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 70, 90 )
        elseif players[playerOnBoard].hp == 1 then
            love.graphics.draw(players[playerOnBoard].image3, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 70, 90 )
        end
    elseif playerString == "helena" then
        if players[playerOnBoard].hp == 3 then
            love.graphics.draw(players[playerOnBoard].image, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 70, 90 )
        elseif players[playerOnBoard].hp == 2 then
            love.graphics.draw(players[playerOnBoard].image2, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 70, 90 )
        elseif players[playerOnBoard].hp == 1 then
            love.graphics.draw(players[playerOnBoard].image3, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 70, 90 )
        end
    end
end

function playerGotHit()

    players[playerOnBoard].hp = players[playerOnBoard].hp - 1

    if players[playerOnBoard].hp <= 0 then
        refreshChars()
        playMenuState = "ChangeMenu"
    end
end