
gameover = {}


function gameover:load()
    screen = love.graphics.newImage("assets/interface/Game Over.png")
end

function gameover:update(dt)
    function love.keypressed(key, scancode, isrepeat)
        if key == "escape" then
            levelState = 0
            dialogueState = 1
            playMenuState = "Playing"
            gameState = "MainMenu"
        end
    end
end

function gameover:draw(dt)
    love.graphics.draw(screen)
end