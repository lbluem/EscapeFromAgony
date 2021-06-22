
dialogue = {}

--[[ dialogue.speaker = "Helena" ]] --[[ Wer am speaken ist yeah ]]
dialogue.sequence = 1 --[[ Sätze bekommen Nummern ]]

local nameFont = nil


function dialogue:load()

    nameFont = love.graphics.newFont(50)

    dialogue.will = love.graphics.newImage("assets/char/Will/Will.png")
    dialogue.helena = love.graphics.newImage("assets/char/Helena/Helena.png")

    gameOver = love.graphics.newImage("assets/interface/Game Over.png")

    dialogueLength = {}
    dialogueLength[1] = 10
    dialogueLength[2] = 7
    dialogueLength[3] = 15
    dialogueLength[4] = 7
    dialogues = {}

    for i = 1,4,1 do
        dialogues[i] = {}
        for j = 1,dialogueLength[i],1 do
            dialogues[i][j] = {}
            dialogues[i][j] = love.graphics.newImage("assets/dialogue/"..i.."/"..i.."."..j..".png")
        end
    end

end

function dialogue:update(dt)
    function love.keypressed(key, scancode, isrepeat)
        if key == "space" then
            dialogue.sequence = dialogue.sequence +1

            sound_click = love.audio.newSource("assets/sound/342200__christopherderp__videogame-menu-button-click.wav", "stream")
            sound_click:setVolume(0.18)
            love.audio.play(sound_click)

            for i, player in ipairs(players) do
                players[i].hp = 3
            end
        --[[ elseif key == "escape" then
            gameState = "MainMenu" ]]
        end
    end
    if dialogue.sequence > dialogueLength[dialogueState] and levelState <= 2 then
        --[[ Spielfeld wird wieder normalisiert ]]
        player.posX = boardArray[1][1][1]
        player.posY = boardArray[1][1][2]
        if #enemies == 0 then
            x1 = love.math.random(3,5)
            y1 = love.math.random(2,4)
            addEnemy(1,x1,y1)
            if levelState ~= 0 then
                repeat
                    x2 = love.math.random(3,5)
                    y2 = love.math.random(2,4)
                until x1 ~= x2 and y1 ~= y2
                addEnemy(2,x2,y2)
                if levelState ~= 1 then
                    repeat
                        x3 = love.math.random(3,5)
                        y3 = love.math.random(2,4)
                    until x3 ~= x1 and x3 ~= x2 
                    and y3 ~= y1 and y3~= y2
                    addEnemy(3,x3,y3)
                end
            end
        end

        dialogue.sequence = 1

        pickPosX = pickerArray[1][1][1]
        pickPosY = pickerArray[1][1][2]
        if levelState < 3 then
            levelState = levelState + 1
        end
        isSelected = false
        yourTurn = true
        canAttack = false
        canMove = true
        gameState = "Game"
        --[[ print("Kommendes Level wurde vorbereitet") ]]
    
    end
end

function dialogue:draw(dt)

    if levelState <= 3 then
            
        if dialogue.sequence <= dialogueLength[dialogueState] then
            love.graphics.draw(dialogues[dialogueState][dialogue.sequence])
        else
            gameState = "GameOver"
            --[[ love.graphics.draw(gameOver)
            levelState = 0
            dialogueState = 1 ]]
        end
    end
end