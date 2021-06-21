--[[ Spieler "Klasse" ]]

--[[ require "source/figure" ]]

player = {}

players = {}

dead = 0
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

    --[[ HP Anzeige ]]
    if players[playerOnBoard].hp == 3 then
        image_hp = love.graphics.newImage("assets/interface/hp_3_3.png")
        --[[               source  | x position                                    | y | r | scaling  | offset  ]]
        love.graphics.draw(image_hp, love.graphics.getWidth() - image_hp:getWidth(), 40, 0, 0.25, 0.25, -1600, 0)
    elseif players[playerOnBoard].hp == 2 then
        image_hp = love.graphics.newImage("assets/interface/hp_3_2.png")
        --[[               source  | x position                                    | y | r | scaling  | offset  ]]
        love.graphics.draw(image_hp, love.graphics.getWidth() - image_hp:getWidth(), 40, 0, 0.25, 0.25, -1600, 0)
    elseif players[playerOnBoard].hp == 1 then
        image_hp = love.graphics.newImage("assets/interface/hp_3_1.png")
        --[[               source  | x position                                    | y | r | scaling  | offset  ]]
        love.graphics.draw(image_hp, love.graphics.getWidth() - image_hp:getWidth(), 40, 0, 0.25, 0.25, -1600, 0)
    end

end

function playerGotHit()

    players[playerOnBoard].hp = players[playerOnBoard].hp - 1

    if players[playerOnBoard].hp >= 1 then
        if playerString == "will" then
            --[[ "UGH" Hit Male Sound ]]
            sound_ugh_male = love.audio.newSource("assets/sound/209181__lukesharples__ugh.wav", "stream")
            sound_ugh_male:setVolume(0.42)
            love.audio.play(sound_ugh_male)
        elseif playerString == "helena" then
            --[[ "UGH" Hit Female Sound ]]
            sound_ugh_female = love.audio.newSource("assets/sound/266285__montblanccandies__ugh-9.wav", "stream")
            sound_ugh_female:setVolume(0.22)
            love.audio.play(sound_ugh_female)
        end
    end

    if players[playerOnBoard].hp <= 0 then
        print("Ich gucke ob alle tot sind")
        for i, player in ipairs(players) do
            if player.hp <= 0 then
                dead = dead + 1
            end
        end
        if dead >= 2 then
            print("Es sind alle Spieler tot")
            gameState = "GameOver"
        end
        

        if playerString == "will" then
            sound_die = love.audio.newSource("assets/sound/338145__artordie__scream-ugh.wav", "stream")
            sound_die:setVolume(0.18)
            love.audio.play(sound_die)
        elseif playerString == "helena" then
            sound_die_female = love.audio.newSource("assets/sound/die_female.wav", "stream")
            sound_die_female:setVolume(0.42)
            love.audio.play(sound_die_female)
        end
        
        refreshChars()
        if dead ~= 0 then
            playMenuState = "ChangeMenu"
        end
        dead = 0
    end
end