
dialogue = {}

--[[ dialogue.speaker = "Helena" ]] --[[ Wer am speaken ist yeah ]]
dialogue.sequence = 1 --[[ Sätze bekommen Nummern ]]

local nameFont = nil


function dialogue:load()

    nameFont = love.graphics.newFont(50)

    dialogue.will = love.graphics.newImage("assets/char/Will/Will.png")
    dialogue.helena = love.graphics.newImage("assets/char/Helena/Helena.png")

    dialogueLength = {}
    dialogueLength[1] = 10
    dialogueLength[2] = 7
    dialogueLength[3] = 14
    dialogueLength[4] = 6
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
            for i, player in ipairs(players) do
                players[i].hp = 3
            end
        end
    end
    if dialogue.sequence > dialogueLength[dialogueState] and levelState <= 3 then

        --[[ Spielfeld wird wieder normalisiert ]]
        player.posX = boardArray[1][1][1]
        player.posY = boardArray[1][1][2]
        if #enemies == 0 then
            x1 = love.math.random(3,5)
            y1 = love.math.random(2,4)
            addEnemy(1,x1,y1)
            if levelState ~= 1 then
                repeat
                    x2 = love.math.random(3,5)
                    y2 = love.math.random(2,4)
                until x1 ~= x2 and y1 ~= y2
                addEnemy(3,x2,y2)
            end
        end

        dialogue.sequence = 1
        dialogueState = dialogueState + 1

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


    end
end

function dialogue:draw(dt)

    --[[     love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill",0,0,absX,absY) ]]
    --[[ if dialogueState == 0 then ]]
    if levelState ~= 3 then
            love.graphics.draw(dialogues[dialogueState][dialogue.sequence])
        --[[ love.graphics.setColor(1,1,1,1)
        love.graphics.draw(dialogue.will, 400, 250, 0, -0.4,0.4)
        love.graphics.draw(dialogue.helena, 900, 250, 0, 0.4, 0.4)
        love.graphics.setColor(1,1,1,0.4)
        love.graphics.rectangle("fill",0,absY/1.5,absX,absY)
        love.graphics.setColor(0,0,0,0.85)
        love.graphics.print("Will", nameFont, 150,(absY/1.5)+15)
        love.graphics.print("Helena", nameFont, 1030,(absY/1.5)+15)
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.print("Welcome to the placeholder. Press SPACE (twice) to continue", 150, 50, 0,0.6,0.6) ]]
    elseif levelstate == 3 then
        print("DAS ENDE WURDE ERREICHT")
        love.graphics.setColor(1,1,1,1)
        love.graphics.print("THE END", 150, 50, 0,0.6,0.6)
    end
    --[[ end ]]
end