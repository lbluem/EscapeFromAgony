
dialogue = {}

dialogue.speaker = "Helena" --[[ Wer am speaken ist yeah ]]
dialogue.sequence = 0 --[[ Sätze bekommen Nummern ]]

local nameFont = nil


function dialogue:load()

    nameFont = love.graphics.newFont(50)

    dialogue.will = love.graphics.newImage("assets/char/Will.png")
    dialogue.helena = love.graphics.newImage("assets/char/Helena.png")

end

function dialogue:update(dt)

    function love.keypressed(key, scancode, isrepeat)
        if key == "space" then
            dialogue.sequence = dialogue.sequence +1
        end
    end
    if dialogue.sequence >= 2 then
        levelState = levelState + 1
        gameState = "Game"
    end
end

function dialogue:draw(dt)

    --[[     love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill",0,0,absX,absY) ]]
    if dialogueState == 1 then
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(dialogue.will, 400, 250, 0, -0.4,0.4)
        love.graphics.draw(dialogue.helena, 900, 250, 0, 0.4, 0.4)
        love.graphics.setColor(1,1,1,0.4)
        love.graphics.rectangle("fill",0,absY/1.5,absX,absY)
        love.graphics.setColor(0,0,0,0.85)
        love.graphics.print("Will", nameFont, 150,(absY/1.5)+15)
        love.graphics.print("Helena", nameFont, 1030,(absY/1.5)+15)
        
    end

end