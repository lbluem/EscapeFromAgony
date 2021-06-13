--[[ Spieler "Klasse" ]]

--[[ require "source/figure" ]]

player = {}

players = {}


--[[ Spieler Direction ]]

--[[ Wie weit kann sich der Spieler bewegen ]]
playMoveLimit = 2

playerString = "will"

--[[ player.lp = 3 ]]

playerOnBoard = 0

function player:load()
  
    will = {
        image = love.graphics.newImage("assets/char/tiny Will.png"),
        name = "will",
        hp = 3,
        aRange = 1,
        mRange = 2,
        combo = 1
    }
    helena = {
        image = love.graphics.newImage("assets/char/tiny Helena wp.png"),
        name = "helena",
        hp = 3,
        aRange = 2,
        mRange = 2,
        combo = 0
    }
    godfired = {
        image = love.graphics.newImage("assets/char/tiny Helena.png"),
        name = "godfired",
        hp = 6,
        aRange = 1,
        mRange = 1,
        combo = 0
    }
    
    --[[ Sprite der Spielerfigur ]]
    player.will = love.graphics.newImage("assets/char/tiny Will.png")
    player.helena = love.graphics.newImage("assets/char/tiny Helena wp.png")


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
        love.graphics.draw(player.will, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 62.5, 62.5 )
    elseif playerString == "helena" then
        love.graphics.draw(player.helena, player.posX + figDistX, player.posY + figDistY, 0, playDir,1, 62.5, 62.5 )
    end
end

function playerGotHit()

    players[playerOnBoard].hp = players[playerOnBoard].hp - 1

    if players[playerOnBoard].hp <= 0 then
        refreshChars()
        playMenuState = "ChangeMenu"
    end
end